/* eslint-disable linebreak-style */
/* eslint-disable indent */
/* eslint-disable linebreak-style */
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
    console.log(`Found ${userGroups}`);
    return userGroups;
  });

export const groupNotificationTrigger = functions.firestore
  .document('projects/{projectId}/groupChats/{groupId}/messages/{docId}')
  .onWrite(async (change, context) => {
    // get tokens for the group chat
    const pid = context.params.projectId!;
    const gid = context.params.groupId!;
    const group = await db.doc(`projects/${pid}/groupChats/${gid}`).get();
    const groupData = group.data()!;
    const groupTokens = groupData.tokens!;
    return messaging.sendMulticast({
      tokens: groupTokens,
      notification: {
        title: 'New notification',
        body: 'this is a new notification',
      },
    });
  });
