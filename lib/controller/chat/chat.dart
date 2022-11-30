import 'package:mannergamer/utilites/index/index.dart';

class ChatController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 채팅하고 있는 유저의 채팅리스트 담는 RxList 변수 */
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  /* 채팅방안의 모든 메시지 담는 RxList 변수 */
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  /* 상대 메시지에서 프로필 보여주는 bool 값 */
  RxBool isShowProfile = false.obs;
  /* 메시지시간 표시에 대한 bool 값 */
  RxBool isShowTime = false.obs;
  /* 메시지시간 표시에 대한 bool 값 */
  RxBool isShowDate = false.obs;
  /* 현재 유저의 uid */
  final _currentUid = FirebaseAuth.instance.currentUser!.uid.toString();
  ScrollController scroll = ScrollController(keepScrollOffset: false);

  @override
  void onInit() {
    super.onInit();
    scroll; //채팅페이지 스크롤
    chatRoomList.bindStream(readAllChatList()); //채팅방리스트 스트림으로 받기
  }

  @override
  void onClose() {
    scroll.dispose(); //채팅페이지의 스크롤 끄기
    super.onClose();
  }

/* 새로운 채팅 입력 시 채팅방 생성하기 */
  Future createNewChatRoom(ChatRoomModel chatRoomModel) async {
    final res = await _chatDB.doc(chatRoomModel.chatRoomId).get();
    //채팅방이 존재하지 않는다면? 새로운 채팅방 만듬
    if (!res.exists)
      //Chat(col) - 채팅방UID(Doc)
      await _chatDB.doc(chatRoomModel.chatRoomId).set({
        'chatRoomId': chatRoomModel.chatRoomId,
        'postId': chatRoomModel.postId,
        'members': chatRoomModel.members,
        'postingUser': chatRoomModel.postingUser,
        'contactUser': chatRoomModel.contactUser,
        'unReadCount': chatRoomModel.unReadCount,
        'lastContent': chatRoomModel.lastContent,
        'updatedAt': chatRoomModel.updatedAt,
      });
  }

  /* 새로운 채팅 입력 시 메시지DB 추가하기 */
  Future sendNewMessege(MessageModel messageModel, chatRoomId, uid) async {
    await _chatDB.doc(chatRoomId).collection('message').add({
      'content': messageModel.content,
      'idFrom': messageModel.idFrom,
      'idTo': messageModel.idTo,
      'timestamp': messageModel.timestamp,
    }); //메시지 컬렉션에 추가

    await _chatDB.doc(chatRoomId).update({
      'unReadCount.${uid}': FieldValue.increment(1),
    }); //상대 uid의 unReadCount +1
  }

  /* 모든 '채팅' 리스트 스트림으로 받기 */
  Stream<List<ChatRoomModel>> readAllChatList() {
    return _chatDB
        .where('members', arrayContains: _currentUid)
        .orderBy('updatedAt', descending: true) //최신이 맨 위
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return ChatRoomModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 모든 '메시지' 리스트 스트림으로 받기 */
  Stream<List<MessageModel>> readAllMessageList(chatRoomId) {
    return _chatDB
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false) //최신이 맨 아래
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return MessageModel.fromDocumentSnapshot(e);
            }).toList());
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
      'unReadCount.${_currentUid}': 0,
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

    // final messageRef = _chatDB.doc(chatRoomId).collection('message').doc().update({'isRead': isRead});
    // await messageRef
    //     .where('senderId', isNotEqualTo: _currentUid) //상대가 보낸 메시지만 쿼리
    //     .where('isRead', isEqualTo: false).; //그 중 내가 인읽은 메시지만 쿼리
  }

  /* 채팅페이지 들어가면, chattingWith 상대 uid로 업데이트 */
  Future updateChattingWith(uid) async {
    await _userDB.doc(_currentUid).update({'chattingWith': uid});
  }

  /* 채팅페이지에서 나가면, chattingWith 빈값으로 업데이트 */
  Future clearChattingWith() async {
    await _userDB.doc(_currentUid).update({'chattingWith': null});
  }
}
