/* eslint-disable linebreak-style */
/* eslint-disable max-len */
import * as admin from 'firebase-admin';
import * as app from 'firebase-admin/app';

import * as functions from 'firebase-functions';

admin.initializeApp({
  credential: app.applicationDefault(),
});
const db = admin.firestore();
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
