const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

exports.sendNotificationWeb = functions.firestore.document('webcontacts/{userId}/logs/{eventId}').onCreate( async (doc, context) => {

    const documentId = context.params.userId;
    const eventID = context.params.eventId;

    var docSnapshot = await db.collection('webcontacts').doc(documentId).get();

    if (docSnapshot.exists) {

        var data = docSnapshot.data();
    
        let contactMap = {};
        //var tokenList = [];
        //var nameList = [];
        var uidList = [];

        contactMap = data['users'];
        
        function logMapElements(key) {
            //tokenList.push(key.notification_token);
            //nameList.push(key.name);
            uidList.push(key.uid);
        }

        Object.values(contactMap).forEach(logMapElements);
        
        for(var i = 0; i < uidList.length; i++){

            //var token = tokenList[i];
            //var name = nameList[i];
            var uid = uidList[i];

            var userSnapshot = await db.collection('webusers').doc(uid).get();
            var userData = userSnapshot.data();

            functions.logger.log(userData);
            var token = userData['notification_token'];

            if(token == '' || token == null) continue;

            var name = contactMap[uid]['name'];

            var message = {
                notification: {
                    title: `wseen`,
                    body: `${name} is online now!`,
                    icon: ``,
                    sound: 'default',
                }
            }
    
            const response = await admin.messaging().sendToDevice(token, message);
            functions.logger.log('notification gönderildi');
        }
    }
});