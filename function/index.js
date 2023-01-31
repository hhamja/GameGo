const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp();

// 채팅 메시지 푸시 알림에 대한 함수
exports.chatNotification = functions
  .region("asia-northeast3")
  .firestore.document("chat/{chatRoomId}/message/{messageId}")
  .onCreate((snap, context) => {
    // 메시지 생성시 트리거
    console.log("------ START : CHAT PUSH NOTIFICATION ------");
    const doc = snap.data();
    const chatRoomId = context.params.chatRoomId;
    const idFrom = doc.idFrom;
    const idTo = doc.idTo;
    const contentMessage = doc.content;
    // 메시지 타입(appoint, message 두개 존재함)
    const messageType = doc.type;
    var postId;

    // 메시지 받은 유저정보 받기
    // pushToken값이 존재, chattringWith와 보낸사람 uid가 다르다면? 채팅 push 알림 보내기
    // uid말고 chatRoomId로 할지 고민되었지만, 메시지 model에 chatRoomId를
    // 추가해줘야하므로 일단을 알림이 제대로 작동하는지 확인하기 위해서 그냥 하기로 결정
    admin
      .firestore()
      .collection("user")
      .doc(idTo)
      .get()
      .then(async (snapshotUserTo) => {
        const userTo = snapshotUserTo.data();
        const userToChatNtf = userTo["chatPushNtf"];
        const userNameTo = userTo["userName"];
        console.log(`Found user to: ${userNameTo}`);

        if (
          userToChatNtf == true &&
          userTo["chattingWith"] != idFrom &&
          messageType == "message"
        ) {
          // userFrom이 현재 채팅상대가 아니고 userTo의 메시지 알림 설정을 ON으로 한 경우
          // chatRoomId를 통해 postId 데이터 가져오기
          await admin
            .firestore()
            .collection("chat")
            .doc(chatRoomId)
            .get()
            .then((e) => {
              var snapshot = e.data();
              postId = snapshot["postId"];
            });
          // 메시지 보낸 유저 정보 가져오기
          admin
            .firestore()
            .collection("user")
            .doc(idFrom)
            .get()
            .then((snapshotUserFrom) => {
              const userFrom = snapshotUserFrom.data();
              const userNameFrom = userFrom["userName"];
              const profileFrom = userFrom["profileUrl"];
              console.log(`Found user from: ${userNameFrom}`);
              // 푸시알림 정보
              const payload = {
                notification: {
                  title: "매너게이머 채팅알림",
                  body: `${userNameFrom} : ${contentMessage}`,
                  badge: "1",
                  sound: "default",
                },
                // 채팅페이지로 페이지 이동을 위한 데이터 전달
                // 이동 시 아규먼트로 데이터 전달 위해
                // chatRoomId, postId, 상대의 uid, 닉네임, 프로필 데이터에 넣기
                data: {
                  click_action: "FLUTTER_NOTIFICATION_CLICK",
                  type: "message",
                  // 채팅 페이지
                  screen: "/chatscreen",
                  chatRoomId: String(chatRoomId),
                  postId: String(postId),
                  uid: String(idFrom),
                  userName: String(userNameFrom),
                  profileUrl: String(profileFrom),
                },
              };
              // 메시지 받은 유저의 디바이스에 push 채팅 알림 보내기
              return admin
                .messaging()
                .sendToDevice(userTo["pushToken"], payload)
                .then((response) => {
                  console.log(userTo["pushToken"]);
                  console.log("Successfully sent message:", response);
                })
                .catch((error) => {
                  console.log("Error sending message:", error);
                });
            });
        } else if (messageType == "appoint") {
          console.log("messageType == appoint");
        } else if (userTo["pushToken"] == "") {
          console.log("pushToken가 null임");
        } else {
          console.log("유저 찾을 수가 없어요");
        }
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
    const idFrom = doc.idFrom;
    const idTo = doc.idTo;
    const chatRoomId = doc.chatRoomId;
    const postId = doc.postId;
    const postTitle = doc.postTitle;
    const ntfContent = doc.content;
    // 알림 타입(appoint, review, notice, favorite)
    const ntfType = doc.type;

    // 알림받은 유저의 fcm토큰 정보 받아서 푸시 알림 보내기
    admin
      .firestore()
      .collection("user")
      .doc(idTo)
      .get()
      .then((snapshotUserTo) => {
        const userTo = snapshotUserTo.data();
        console.log(`Found user to: ${userTo["userName"]}`);
        const activityNtf = userTo["activityPushNtf"];
        const marketingConsent = userTo["marketingConsent"];
        const nightNtf = userTo["nightPushNtf"];
        console.log(activityNtf);
        console.log(nightNtf);
        console.log(marketingConsent);
        console.log(ntfType);

        // 알림 타입에 따라 푸시알림 보내기
        if (ntfType == "review" && activityNtf == true) {
          // 매너후기 알림
          console.log("review 알림 조건식 통과");
          // userFrom 정보 받기
          admin
            .firestore()
            .collection("user")
            .doc(idFrom)
            .get()
            .then((snapshotUserFrom) => {
              const userFrom = snapshotUserFrom.data();
              const userNameFrom = userFrom["userName"];
              const profileFrom = userFrom["profileUrl"];
              console.log(`Found user from: ${userNameFrom}`);
              // 매너 후기 알림을 푸시할 메시지에 대한 설정
              const payload = {
                notification: {
                  title: "매너 후기 알림",
                  body: `"${userNameFrom}"님이 매너 후기를 보냈어요.`,
                  badge: "1",
                  sound: "default",
                
                },
                // 채팅페이지로 페이지 이동을 위한 데이터 전달
                // 이동 시 아규먼트로 데이터 전달 위해
                // chatRoomId, postId, 상대의 uid, 닉네임, 프로필 데이터에 넣기
                data: {
                  click_action: "FLUTTER_NOTIFICATION_CLICK",
                  type: "review",
                  // 채팅 페이지
                  screen: "/chatscreen",
                  chatRoomId: String(chatRoomId),
                  postId: String(postId),
                  uid: String(idFrom),
                  userName: String(userNameFrom),
                  profileUrl: String(profileFrom),
                },
              };
              console.log(`payload: ${payload}`);
              // 푸시 알림 보내기
              return admin
                .messaging()
                .sendToDevice(userTo["pushToken"], payload)
                .then((response) => {
                  console.log(userTo["pushToken"]);
                  console.log("Successfully sent :", response);
                })
                .catch((error) => {
                  console.log("Error sending :", error);
                });
            });
        } else if (ntfType == "appoint" && activityNtf == true) {
          // 약속 설정 알림
          console.log("약속 알림 조건식 통과");
          // userFrom 정보 받기
          admin
            .firestore()
            .collection("user")
            .doc(idFrom)
            .get()
            .then((snapshotUserFrom) => {
              const userFrom = snapshotUserFrom.data();
              const userNameFrom = userFrom["userName"];
              const profileFrom = userFrom["profileUrl"];
              console.log(`Found user from: ${userNameFrom}`);
              // 약속설정 알림을 푸시할 메시지에 대한 설정
              const payload = {
                notification: {
                  title: "약속 설정 알림",
                  body: `"${userNameFrom}"님이 약속을 잡았어요. 날짜와 시간을 확인하세요.`,
                  badge: "1",
                  sound: "default",
                },
                // 채팅페이지로 페이지 이동을 위한 데이터 전달
                // 이동 시 아규먼트로 데이터 전달 위해
                // chatRoomId, postId, 상대의 uid, 닉네임, 프로필 데이터에 넣기
                data: {
                  click_action: "FLUTTER_NOTIFICATION_CLICK",
                  type: "appoint",
                  // 채팅 페이지
                  screen: "/chatscreen",
                  chatRoomId: String(chatRoomId),
                  postId: String(postId),
                  uid: String(idFrom),
                  userName: String(userNameFrom),
                  profileUrl: String(profileFrom),
                },
              };
              // 푸시 알림 보내기
              return admin
                .messaging()
                .sendToDevice(userTo["pushToken"], payload)
                .then((response) => {
                  console.log(userTo["pushToken"]);
                  console.log("Successfully sent :", response);
                })
                .catch((error) => {
                  console.log("Error sending :", error);
                });
            });
        } else if (ntfType == "favorite" && activityNtf == true) {
          // 관심 게시글
          console.log("관심게시글 알림 조건식 통과");
          // userFrom 정보 받기
          admin
            .firestore()
            .collection("user")
            .doc(idFrom)
            .get()
            .then((snapshotUserFrom) => {
              const userFrom = snapshotUserFrom.data();
              const userNameFrom = userFrom["userName"];
              console.log(`Found user from: ${userNameFrom}`);
              // 관심 게시글 알림을 푸시할 메시지에 대한 설정
              const payload = {
                notification: {
                  title: "게시글 관심 알림",
                  body: `"${userNameFrom}님이 "${postTitle}"를 관심 게시글로 등록했어요.`,
                  badge: "1",
                  sound: "default",
                },
                // 게시글 페이지 이동을 위한 데이터 전달
                // 이동 시 아규먼트로 데이터 전달 위해
                // chatRoomId, postId, 상대의 uid, 닉네임, 프로필 데이터에 넣기
                data: {
                  click_action: "FLUTTER_NOTIFICATION_CLICK",
                  type: "favorite",
                  // 게시글 페이지
                  screen: "/postdetail",
                  postId: String(postId),
                },
              };
              // 푸시 알림 보내기
              return admin
                .messaging()
                .sendToDevice(userTo["pushToken"], payload)
                .then((response) => {
                  console.log(userTo["pushToken"]);
                  console.log("Successfully sent :", response);
                })
                .catch((error) => {
                  console.log("Error sending :", error);
                });
            });
        } else if (ntfType == "notice" && marketingConsent == true) {
          // 앱 이벤트 및 소식
          console.log("앱 소식 알림 조건식 통과");
          // 앱 공지 알림을 푸시할 메시지에 대한 설정
          const payload = {
            notification: {
              title: "매너게이머 새소식",
              body: `${ntfContent}`,
              badge: "1",
              sound: "default",
            },
          };
          // 푸시 알림 보내기
          return admin
            .messaging()
            .sendToDevice(userTo["pushToken"], payload)
            .then((response) => {
              console.log(userTo["pushToken"]);
              console.log("Successfully sent :", response);
            })
            .catch((error) => {
              console.log("Error sending :", error);
            });
        }
        console.log("IF문의 else 결과 값");
        return null;
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
