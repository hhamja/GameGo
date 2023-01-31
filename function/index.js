const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/* 채팅 메시지 푸시 알림에 대한 함수 */
exports.chatNotification = functions
  .region("asia-northeast3")
  .firestore.document("chat/{chatRoomId}/message/{messageId}") //메시지 문서경로로 지정
  .onCreate(async (snap, context) => {
    // 문서가 처음 작성될 때(새 메시지가 생성될 때) 트리거
    console.log("------ START : CHAT PUSH NOTIFICATION ------");
    const doc = snap.data();

    console.log(doc.idFrom);
    console.log(doc.idTo);
    // 메시지가 오가는 채팅방의 id
    const chatRoomId = context.params.chatRoomId;
    // 게시글 정보를 보여주기 위한 게시글 id
    var postId;
    console.log(chatRoomId);
    const idFrom = doc.idFrom; // 보낸 사람 uid
    const idTo = doc.idTo; // 받은 사람 uid
    const contentMessage = doc.content; // 메시지 내용
    const messageType = doc.type; // 메시지 타입(appoint, message 두개 존재함)

    // postId를 담기위해 chatRoomId를 이용해서 채팅방 데이터 받기
    await admin
      .firestore()
      .collection("chat")
      .doc(chatRoomId)
      .get()
      .then((e) => {
        const snapshot = e.data();
        postId = snapshot["postId"];
        console.log(postId);
      });

    /* 
    메시지 받은 유저정보 받기
    pushToken값이 존재, chattringWith와 보낸사람 uid가 다르다면? 채팅 push 알림 보내기
    uid말고 chatRoomId로 할지 고민되었지만, 메시지 model에 chatRoomId를 추가해줘야하므로 일단을 알림이 제대로 작동하는지 확인하기 위해서 그냥 하기로 결정 
    */
    return admin
      .firestore()
      .collection("user")
      .where("uid", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          const userToChatNtf = userTo.data().chatPushNtf;
          console.log(`Found user to: ${userTo.data().userName}`);

          // 받은유저 push 토큰 존재, 메시지 타입이 message, 받은 유저가 보낸사람의 채팅방 화면을 보고 있지 않은 경우
          if (
            userToChatNtf == true &&
            userTo.data().chattingWith !== idFrom &&
            messageType === "message"
          ) {
            // 메시지 보낸 유저 정보 가져오기
            admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  const doc = userFrom.data();
                  // 메시지 보낸 사람 닉네임, 매너나이, 프로필
                  const userNameFrom = doc.userName;
                  const mannerAgeFrom = doc.mannerAge;
                  const profileFrom = doc.userName;

                  console.log(`Found user from: ${userNameFrom}`);
                  const payload = {
                    notification: {
                      title: "매너게이머 채팅알림",
                      body: `${userNameFrom} : ${contentMessage}`,
                      badge: "1",
                      sound: "default",
                    },
                    // 채팅페이지로 페이지 이동을 위한 데이터 전달
                    // 이동 시 아규먼트로 데이터 전달 위해 chatRoomId, postId
                    // 상대의 uid, 닉네임, 매너나이, 프로필 데이터에 넣기
                    data: {
                      
                      type: "message",
                      chatRoomId: String(chatRoomId),
                      postId: String(postId),
                      uid: String(idFrom),
                      userName: String(userNameFrom),
                      mannerAge: String(mannerAgeFrom),
                      profileUrl: String(profileFrom),
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
      })
      .catch((error) => {
        console.log("UserTo의 정보를 얻는 admin 에러 :", error);
      });
  });

/* 매너후기, 관심게시글, 약속, 이벤트 및 소식 푸시알림 */
exports.activityAndMarketingNotification = functions
  .region("asia-northeast3")
  .firestore.document("notification/{notificationId}")
  .onCreate(async (snap, context) => {
    console.log("------ START : ACTIVITY & Marketing NOTIFICATION ------");

    const doc = snap.data();

    console.log(doc.idFrom);
    console.log(doc.idTo);

    const idFrom = doc.idFrom; //보낸 사람 uid
    const idTo = doc.idTo; //받은 사람 uid
    const postTitle = doc.postTitle; //게시글 제목
    const ntfContent = doc.content; //알림 내용
    const ntfType = doc.type; //알림 타입(appoint, review, notice, favorite)

    /* 알림받은 유저의 fcm토큰 정보 받아서 푸시 알림 보내기 */
    return admin
      .firestore()
      .collection("user")
      .where("uid", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().userName}`);

          // 후기, 관심게시글, 약속설정 알림에 대한 on/off
          const activityNtf = userTo.data().activityPushNtf;
          // 이벤트 및 앱 소식에 대한 on/off
          const marketingConsent = userTo.data().marketingConsent;
          // 야간시간 수신 알림
          const nightNtf = userTo.data().nightPushNtf;
          console.log(activityNtf);
          console.log(nightNtf);
          console.log(marketingConsent);
          console.log(ntfType);

          /// User From의 이름을 받고 푸시알림에 설정하기
          if (ntfType == "review" && activityNtf == true) {
            // 매너후기
            console.log("review 알림 조건식 통과");
            return admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  const userName = userFrom.data().userName;
                  console.log(`Found user from: ${userName}`);
                  // 매너 후기 알림을 푸시할 메시지에 대한 설정
                  const payload = {
                    notification: {
                      title: "매너 후기 알림",
                      body: `"${userName}"님이 매너 후기를 보냈어요.`,
                      badge: "1",
                      sound: "default",
                      // click_action: "FLUTTER_NOTIFICATION_CLICK",
                    },
                  };
                  console.log(`payload: ${payload}`);
                  // 푸시 알림 보내기
                  return admin
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
          } else if (ntfType == "appoint" && activityNtf == true) {
            /// 약속 설정
            console.log("약속 알림 조건식 통과");
            return admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  const userName = userFrom.data().userName;
                  console.log(`Found user from: ${userName}`);
                  // 약속설정 알림을 푸시할 메시지에 대한 설정
                  const payload = {
                    notification: {
                      title: "약속 설정 알림",
                      body: `"${userName}"님이 약속을 잡았어요. 날짜와 시간을 확인하세요.`,
                      badge: "1",
                      sound: "default",
                      // click_action: "FLUTTER_NOTIFICATION_CLICK",
                    },
                  };
                  // 푸시 알림 보내기
                  return admin
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
          } else if (ntfType == "favorite" && activityNtf == true) {
            /// 관심 게시글
            console.log("관심게시글 알림 조건식 통과");
            return admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  const userName = userFrom.data().userName;
                  console.log(`Found user from: ${userName}`);
                  // 관심 게시글 알림을 푸시할 메시지에 대한 설정
                  const payload = {
                    notification: {
                      title: "게시글 관심 알림",
                      body: `"${userName}님이 "${postTitle}"를 관심 게시글로 등록했어요.`,
                      badge: "1",
                      sound: "default",
                      // click_action: "FLUTTER_NOTIFICATION_CLICK",
                    },
                  };
                  // 푸시 알림 보내기
                  return admin
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
          } else if (ntfType == "notice" && marketingConsent == true) {
            // 앱 이벤트 및 소식
            console.log("앱 소식 알림 조건식 통과");
            return admin
              .firestore()
              .collection("user")
              .where("uid", "==", idFrom)
              .get()
              .then((querySnapshot2) => {
                querySnapshot2.forEach((userFrom) => {
                  const userName = userFrom.data().userName;
                  console.log(`Found user from: ${userName}`);
                  // 앱 공지 알림을 푸시할 메시지에 대한 설정
                  const payload = {
                    notification: {
                      title: "매너게이머 새소식",
                      body: `${ntfContent}`,
                      badge: "1",
                      sound: "default",
                      // click_action: "FLUTTER_NOTIFICATION_CLICK",
                    },
                  };
                  // 푸시 알림 보내기
                  return admin
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
          }
          console.log("IF문의 else 결과 값");
          return null;
        });
      })
      .catch((error) => {
        console.log("UserTo의 정보를 얻는 admin 에러 :", error);
      });
  });

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
