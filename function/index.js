const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/* 채팅 메시지 푸시 알림에 대한 함수 */
exports.chatNotification = functions
  .region("asia-northeast3")
  .firestore.document("chat/{chatRoomId}/message/{messageId}") //메시지 문서경로로 지정
  .onCreate((snap, context) => {
    //문서가 처음 작성될 때(새 메시지가 생성될 때) 트리거
    console.log("----------------START : MESSAGE FUNCTION--------------------");

    const doc = snap.data();

    console.log(doc.idFrom);
    console.log(doc.idTo);

    const idFrom = doc.idFrom; //보낸 사람 uid
    const idTo = doc.idTo; //받은 사람 uid
    const contentMessage = doc.content; //메시지 내용
    const messageType = doc.type; //메시지 타입(appoint, message 두개 존재함)

    /* 메시지 받은 유저정보 받기
     * pushToken값이 존재, chattringWith와 보낸사람 uid가 다르다면? 채팅 push 알림 보내기
     * uid말고 chatRoomId로 할지 고민되었지만, 메시지 model에 chatRoomId를 추가해줘야하므로 일단을 알림이 제대로 작동하는지 확인하기 위해서 그냥 하기로 결정 */
    admin
      .firestore()
      .collection("user")
      .where("uid", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().userName}`);

          //받은유저 push 토큰 존재, 메시지 타입이 message, 받은 유저가 보낸사람의 채팅방 화면을 보고 있지 않은 경우
          if (
            userTo.data().pushToken !== "" &&
            userTo.data().chattingWith !== idFrom &&
            messageType === "message"
          ) {
            /* 메시지 보낸 유저 정보 가져오기 */
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
                      title: "매너게이머 채팅알림",
                      body: `${userFrom.data().userName} : ${contentMessage}`,
                      badge: "1",
                      sound: "default",
                    },
                  };
                  // 메시지 받은 유저의 디바이스에 push 채팅 알림 보내기
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then((response) => {
                      console.log(userTo.data().pushToken);
                      console.log("Successfully sent message:", response);
                    })
                    .catch((error) => {
                      console.log("Error sending message:", error);
                    });
                });
              });
          } else if (messageType === "appoint") {
            console.log("messageType == appoint");
          } else if (userTo.data().pushToken === "") {
            console.log("pushToken가 null임");
          } else {
            console.log("유저 찾을 수가 없어요");
          }
        });
      });
    console.log("null");
    return null;
  });

/* 매너후기, 관심게시글, 약속설정, 앱 공지 및 마케팅 푸시알림 함수 */
exports.reviewNotification = functions
  .region("asia-northeast3")
  .firestore.document("notification/{notificationId}")
  .onCreate((snap, context) => {
    console.log("----------------START : FUNCTION--------------------");

    const doc = snap.data();

    console.log(doc.idFrom);
    console.log(doc.idTo);

    const idFrom = doc.idFrom; //보낸 사람 uid
    const idTo = doc.idTo; //받은 사람 uid
    const postTitle = doc.postTitle; //게시글 제목
    const ntfContent = doc.content; //알림 내용
    const ntfType = doc.type; //알림 타입(appoint, review, notice, favorite)

    /* 알림받은 유저의 fcm토큰 정보 받아서 푸시 알림 보내기 */
    admin
      .firestore()
      .collection("user")
      .where("uid", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().userName}`);
          /* User From의 이름을 받고 푸시알림에 대한 설정하기 */
          //하단의 if문을 여기 상단으로 빼서 하기 왜냐햐면 그래야 쿼리를 한뱐이라도 안하게 된다.
          admin
            .firestore()
            .collection("user")
            .where("uid", "==", idFrom)
            .get()
            .then((querySnapshot2) => {
              querySnapshot2.forEach((userFrom) => {
                const userName = userFrom.data().userName;
                var payload;
                console.log(`Found user from: ${userName}`);
                // 1. 매너 후기 알림?
                // 유저정보에서 해당하는 알림 bool변수가 true일 떄만 보내지게 수정
                if (ntfType == "review") {
                  payload = {
                    notification: {
                      title: "매너 후기 알림",
                      body: `"${userName}"님이 매너 후기를 보냈어요.`,
                      badge: "1",
                      sound: "default",
                    },
                  };
                }
                // 2. 약속 설정 알림?
                // 유저정보에서 해당하는 알림 bool변수가 true일 떄만 보내지게 수정
                else if (ntfType == "appoint") {
                  payload = {
                    notification: {
                      title: "약속 설정 알림",
                      body: `"${userName}"님이 약속을 잡았어요. 날짜와 시간을 확인하세요.`,
                      badge: "1",
                      sound: "default",
                    },
                  };
                }
                // 3. 관심 게시글 알림?
                // 유저정보에서 해당하는 알림 bool변수가 true일 떄만 보내지게 수정
                else if (ntfType == "favorite") {
                  payload = {
                    notification: {
                      title: "약속 설정 알림",
                      body: `"${userName}님이 약속을 잡았어요. 날짜와 시간을 확인하세요.`,
                      badge: "1",
                      sound: "default",
                    },
                  };
                }
                // 4. 앱 공지 알림?
                // 유저정보에서 해당하는 알림 bool변수가 true일 떄만 보내지게 수정
                else if (ntfType == "notice") {
                  payload = {
                    notification: {
                      title: "매너게이머 새소식",
                      body: `${ntfContent}`,
                      badge: "1",
                      sound: "default",
                    },
                  };
                } null;
                // 푸시 알림 보내기
                admin
                  .messaging()
                  .sendToDevice(userTo.data().pushToken, payload)
                  .then((response) => {
                    console.log(userTo.data().pushToken);
                    console.log("Successfully sent :", response);
                  })
                  .catch((error) => {
                    console.log("Error sending :", error);
                  });
              });
            });
        });
      });
    console.log("null");
    return null;
  });

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
