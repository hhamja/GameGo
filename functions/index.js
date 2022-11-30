const functions = require("firebase-functions");
const admin = require("firebase-admin"); //admin은 auth를 서버에서 처리하게 도와주는 SDK
admin.initializeApp();

exports.sendNotification = functions.firestore
  .document("chat/{chatRoomId}/message/{messageId}") //메시지 문서경로로 지정
  .onCreate((snap, context) => {
    //문서가 처음 작성될 때(새 메시지가 생성될 때) 트리거
    console.log("----------------start function--------------------");

    const doc = snap.data();
    console.log(doc);

    const idFrom = doc.idFrom; //보낸 사람 uid
    const idTo = doc.idTo; //받은 사람 uid
    const contentMessage = doc.content; //메시지 내용

    // Get push token user to (receive)
    admin
      .firestore()
      .collection("user")
      .where("uid", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().userName}`);
          if (
            userTo.data().pushToken &&
            userTo.data().chattingWith !== idFrom
          ) {
            // Get info user from (sent)
            admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  console.log(`Found user from: ${userFrom.data().userName}`);
                  const payload = {
                    notification: {
                      title: `You have a message from "${
                        userFrom.data().userName
                      }"`,
                      body: contentMessage,
                      badge: "1",
                      sound: "default",
                    },
                  };
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then((response) => {
                      console.log("Successfully sent message:", response);
                    })
                    .catch((error) => {
                      console.log("Error sending message:", error);
                    });
                });
              });
          } else {
            console.log("Can not find pushToken target user");
          }
        });
      });
    return null;
  });
// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
