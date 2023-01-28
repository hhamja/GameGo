import 'package:mannergamer/utilites/index/index.dart';

class ChatController extends GetxController {
  final _chatDB = FirebaseFirestore.instance.collection('chat');
  final _userDB = FirebaseFirestore.instance.collection('user');
  ScrollController scroll = ScrollController(keepScrollOffset: false);
  // 채팅하고 있는 유저의 채팅리스트 담는 RxList 변수
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  // 채팅방안의 모든 메시지 담는 RxList 변수
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  // 상대 메시지에서 프로필 보여주는 bool 값
  RxBool isShowProfile = false.obs;
  // 메시지시간 표시에 대한 bool 값
  RxBool isShowTime = false.obs;
  // 메시지시간 표시에 대한 bool 값
  RxBool isShowDate = false.obs;
  // 서로서로 보낸 메시지가 1개 이상인지; 약속설정 가능 여부
  RxBool isOkAppoint = false.obs;
  // 채팅방에서 상대방 매너나이
  RxString mannerAge = ''.obs;
  // 유저정보
  // 탈퇴유저도 담아야하므로 nullable
  Rx<UserModel>? userInfo;

  @override
  void onInit() {
    super.onInit();
    // 채팅방리스트 스트림으로 받기
    chatRoomList.bindStream(readAllChatList());
    scroll;
  }

  @override
  void onClose() {
    //채팅페이지의 스크롤 끄기
    scroll.dispose();
    super.onClose();
  }

  /* 채팅에서 받은 데이터에서 내가 아닌 상대방의 uid로 매너나이 받기 */
  Future getUserMannerAge(uid) async {
    await _userDB.doc(uid).get().then(
      (e) {
        var data = e.data() as Map<String, dynamic>;
        mannerAge.value = data['mannerAge'].toString();
      },
    );
  }

  /* 유저정보 받기 */
  Future getUserInfo(uid) async {
    // 유저정보 경로
    final ref = await _userDB.doc(uid).get();
    // 탈퇴유저인지 확인
    if (ref.exists) {
      // 탈퇴유저가 아닌 경우
      return _userDB.doc(uid).get().then(
            (e) => userInfo?.value = UserModel.fromDocumentSnapshot(e),
          );
    } else {
      // 탈퇴유저
      return userInfo = null;
    }
  }

  /* 새로운 채팅 입력 시 채팅방 생성하기 */
  Future createNewChatRoom(ChatRoomModel chatRoomModel) async {
    // 채팅방이 존재하지 않는다면? chat col에 채팅방 데이터 추가
    final res = await _chatDB.doc(chatRoomModel.chatRoomId).get();
    if (!res.exists)
      // Chat(col) - 채팅방UID(Doc)
      await _chatDB.doc(chatRoomModel.chatRoomId).set({
        'chatRoomId': chatRoomModel.chatRoomId,
        'postId': chatRoomModel.postId,
        'members': chatRoomModel.members,
        'postingUid': chatRoomModel.postingUid,
        'postingUserProfileUrl': chatRoomModel.postingUserProfileUrl,
        'postingUserName': chatRoomModel.postingUserName,
        'contactUid': chatRoomModel.contactUid,
        'contactUserProfileUrl': chatRoomModel.contactUserProfileUrl,
        'contactUserName': chatRoomModel.contactUserName,
        'unReadCount': chatRoomModel.unReadCount,
        'lastContent': chatRoomModel.lastContent,
        'isActive': chatRoomModel.isActive,
        'updatedAt': chatRoomModel.updatedAt,
      });
  }

  /* 새로운 채팅 입력 시 메시지DB 추가하기 */
  Future sendNewMessege(MessageModel messageModel, chatRoomId, uid) async {
    // 메시지 컬렉션에 추가
    _chatDB.doc(chatRoomId).collection('message').add(
      {
        'content': messageModel.content,
        'idFrom': messageModel.idFrom,
        'idTo': messageModel.idTo,
        'type': messageModel.type,
        'timestamp': messageModel.timestamp,
      },
    );
    // 상대 uid의 unReadCount +1
    _chatDB.doc(chatRoomId).update({
      'unReadCount.${uid}': FieldValue.increment(1),
    });
  }

  /* 모든 '채팅' 리스트 스트림으로 받기 */
  Stream<List<ChatRoomModel>> readAllChatList() async* {
    yield* _chatDB
        .where('members', arrayContains: CurrentUser.uid)
        .orderBy('updatedAt', descending: true) //최신이 맨 위
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((e) => ChatRoomModel.fromDocumentSnapshot(e))
              .toList(),
        );
  }

  /* 모든 '메시지' 리스트 스트림으로 받기 */
  Stream<List<MessageModel>> readAllMessageList(chatRoomId) async* {
    yield* _chatDB
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false) //최신이 맨 아래
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (e) => MessageModel.fromDocumentSnapshot(e),
            )
            .toList());
  }

  /* 메시지를 보낼 때 마다 마지막 채팅, 최근 시간 업데이트 */
  Future updateChatRoom(chatRoomId, lastContent, updatedAt) async {
    return await _chatDB.doc(chatRoomId).update({
      'lastContent': lastContent,
      'updatedAt': updatedAt,
    });
  }

  /* 메시지페이지를 나갔을 때 나의 안읽은 메시지 수 0으로 업데이트 */
  Future clearUnReadCount(chatRoomId) async {
    _chatDB.doc(chatRoomId).update({
      'unReadCount.${CurrentUser.uid}': 0,
    }); //나의 안읽은메시지 수 0으로 업데이트
  }

  /* 메시지를 읽은 것에 대한 파이어스토어 값 업데이트 하기
  * 채팅메시지 페이지를 나가는 순간(dispose) 
  현재 메시지들의 isRead값을 true로 업데이트 */
  Future isReadMessage(chatRoomId) async {
    await _chatDB
        .doc(chatRoomId)
        .collection('message')
        .doc()
        .update({'isRead': 'true'});
  }

  /* 채팅페이지 들어가면, chattingWith 상대 uid로 업데이트 */
  Future updateChattingWith(uid) async {
    await _userDB.doc(CurrentUser.uid).update({'chattingWith': uid});
  }

  /* 채팅페이지에서 나가면, chattingWith 빈값으로 업데이트 */
  Future clearChattingWith() async {
    await _userDB.doc(CurrentUser.uid).update({'chattingWith': null});
  }

  /* 상대방의 메시지만 받기 */
  Stream isContactUserMessage(chatRoomId) async* {
    yield* _chatDB
        .doc(chatRoomId)
        .collection('message')
        .where('idFrom', isEqualTo: CurrentUser.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MessageModel.fromDocumentSnapshot(e)));
  }
}
