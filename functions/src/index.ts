/* eslint-disable linebreak-style */
/* eslint-disable padded-blocks */
/* eslint-disable indent */
/* eslint-disable max-len */
import * as admin from 'firebase-admin';
import * as app from 'firebase-admin/app';

import * as functions from 'firebase-functions';

admin.initializeApp({
  credential: app.applicationDefault(),
});
const db = admin.firestore();
const messaging = admin.messaging();
export const getAllowedGroupsForUser = functions.https.onCall(
  async (data, context) => {
    const uid = context.auth!.uid;
    const pid = data.projectId;
    const project = await db.doc(`projects/${pid}`).get();

    const pdata = project.data()!;

    const userRoles: Array<string> = pdata.userRoleMap[uid] || [];
    const projectGroupSnaps = (await db.collection(`projects/${pid}/groupChats`).get()).docs;

    const userGroups: any[] = [];

    projectGroupSnaps.forEach((doc) => {
      const group = doc.data();
      group.allowedRoleIds.forEach((rid: string) => {
        if (userRoles.includes(rid)) {
          userGroups.push(group);
          return;
        }
      });
    });
    return userGroups;
  });

export const groupNotificationTrigger = functions.firestore
  .document('projects/{projectId}/groupChats/{groupId}/messages/{docId}')
  .onWrite(async (change, context) => {
    // get tokens for the group chat
    const pid = context.params.projectId;
    const gid = context.params.groupId;

    // get the message senderData
    const messageData = change.after.data()!;
    const senderId = messageData.senderId;
    const sender = await db.doc(`users/${senderId}`).get();
    const senderData = sender.data()!;

    // get group data
    const group = await db.doc(`projects/${pid}/groupChats/${gid}`).get();
    const project = await db.doc(`projects/${pid}`).get();
    const projectData = project.data()!;
    const groupData = group.data()!;

    const groupMembersList: Set<string> = new Set([]);

    // get the group members
    // based on the allowedRoleIds
    groupData.allowedRoleIds.forEach((rid: string) => {
      Object.entries(projectData.userRoleMap).forEach(([key, value]: any) => {
        value.forEach((innerRid: string) => {
          console.log(innerRid);
          if (innerRid === rid) {
            groupMembersList.add(key);
          }
        });
      });

    });
    console.log(groupMembersList);

    // get the actual device tokens
    const tokenList: Array<string> = [];

    for (const memberId of groupMembersList) {
      const tokenDoc = await db.doc(`tokens/${memberId}`).get();
      const tokenData = tokenDoc.data()!;
      if (memberId != senderId) {
        tokenList.push(tokenData.token);
      }
    }
    console.log(tokenList);
    if (tokenList.length != 0) {
      return messaging.sendMulticast({
        tokens: tokenList,
        notification: {
          title: `${senderData.name} has sent a new message in ${groupData.name}`,
          body: messageData.text,
        },
      });
    } else {
      return Promise.resolve();
    }
  });

const _getTaskProgress = async (pid: string, tid: string) => {

  // calculate the progress by looping over the subtasks
  const subTasksCollection = await db.collection(`projects/${pid}/tasks/${tid}/subTasks`).get();
  if (subTasksCollection.size != 0) {
    let progress = 0;
    const subTasksDocs = subTasksCollection.docs;
    subTasksDocs.forEach((subTaskDoc) => {
      const subTask = subTaskDoc.data()!;
      if (subTask.status.runtimeType === 'complete') {
        progress += 1;
      }
    });
    return Promise.resolve(progress / subTasksCollection.size);
  }

  return Promise.resolve(0);
};


export const _getProjectProgress = async (pid: string) => {
  let progress = 0;
  const tasksCollection = await db.collection(`projects/${pid}/tasks`).get();
  if (tasksCollection.size != 0) {
    const taskDocs = tasksCollection.docs;
    taskDocs.forEach(async (taskDoc) => {
      if (taskDoc.exists) {
        const task = taskDoc.data()!;
        if (task.status.runtimeType === 'complete') {
          progress++;
        } else {
          progress += await _getTaskProgress(pid, task.id);
        }
      }
    });
    return Promise.resolve(progress / tasksCollection.size);
  }
  return Promise.resolve(0);

};

export const taskWatcherTrigger = functions.firestore
  .document('projects/{projectId}/tasks/{taskId}').onWrite(async (change, context) => {

    const pid = context.params.projectId;
    if (!change.after.exists) {
      await db.doc(`projects/${pid}`).update({
        progress: await _getProjectProgress(pid),
      });
      return Promise.resolve();
    }
    const tid = context.params.taskId;
    const beforeStatus = change.before.get('status');
    const afterStatus = change.after.get('status');
    if (beforeStatus !== afterStatus) {
      if (afterStatus.runtimeType === 'complete') {
        await db.doc(`projects/${pid}/tasks/${tid}`).update({
          progress: 1,
        });
      } else {
        await db.doc(`projects/${pid}/tasks/${tid}`).update({
          progress: await _getTaskProgress(pid, tid),
        });
      }
      await db.doc(`projects/${pid}`).update({
        progress: await _getProjectProgress(pid),
      });
    }
    return Promise.resolve();
  });
export const subTaskWatcherTrigger = functions.firestore
  .document('projects/{projectId}/tasks/{taskId}/subTasks/{subTaskId}').onWrite(async (change, context) => {

    const pid = context.params.projectId;
    const tid = context.params.taskId;
    if (!change.after.exists) {
      await db.doc(`projects/${pid}/tasks/${tid}`).update({
        progress: await _getTaskProgress(pid, tid),
      });
      return Promise.resolve();
    }
    const beforeStatus = change.before.get('status');
    const afterStatus = change.after.get('status');
    if (beforeStatus !== afterStatus) {
      let canCompleteTask = true;
      const subTasksCollection = await db.collection(`projects/${pid}/tasks/${tid}/subTasks`).get();

      if (subTasksCollection.size != 0) {
        const subTasksDocs = subTasksCollection.docs;
        subTasksDocs.forEach((subTaskDoc) => {
          const subTask = subTaskDoc.data()!;
          if (subTask.status.runtimeType !== 'complete') {
            canCompleteTask = false;
            return;
          }
        });
      }

      if (canCompleteTask) {
        await db.doc(`projects/${pid}/tasks/${tid}`).update({
          progress: 1,
          canCompleteTask: true,
          status: {
            name: 'Complete',
            runtimeType: 'complete',
          },
        });
      } else {
        await db.doc(`projects/${pid}/tasks/${tid}`).update({
          progress: await _getTaskProgress(pid, tid),
          canCompleteTask: false,
          status: {
            name: 'Incomplete',
            runtimeType: 'incomplete',
          },
        });
      }
      await db.doc(`projects/${pid}`).update({
        progress: await _getProjectProgress(pid),
      });

    }
    return Promise.resolve();

  });
export const taskCountIncrementer = functions.firestore
  .document('projects/{projectId}/tasks/{taskId}').onCreate(async (snap, context) => {
    return snap.ref.parent.parent!.update('numberOfTasks', admin.firestore.FieldValue.increment(1));

  });
export const taskCountDecrementer = functions.firestore
  .document('projects/{projectId}/tasks/{taskId}').onDelete(async (snap, context) => {
    return snap.ref.parent.parent!.update('numberOfTasks', admin.firestore.FieldValue.increment(-1));

  });
