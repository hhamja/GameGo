import 'package:mannergamer/utilites/index/index.dart';

class ChatController extends GetxController {
  /* 파이어스토어 Chat 컬렉션 참조 */
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
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
  // ScrollController scroll = ScrollController(keepScrollOffset: false);
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
  Future sendNewMessege(MessageModel messageModel, chatRoomId) async {
    //채팅(col) - 그룹UID(Doc) - 메시지(Col) - 메시지내용()
    await _chatDB.doc(chatRoomId).collection('message').add({
      'content': messageModel.content,
      'senderId': messageModel.senderId,
      'isRead': messageModel.isRead,
      'timestamp': messageModel.timestamp,
    }); //메시지 컬렉션에 추가
    await _chatDB.doc(chatRoomId).update({
      'unReadCount.${_currentUid}': FieldValue.increment(1),
    }); //ChatRoom의 unReadCount +1
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

  /* 채팅방 나가기, 삭제는 상대유저랑 내가 둘다 나가기를 햇을 경우 삭제하기 */
  Future deleteChat(chatRoomId) async {
    //손봐야함
    try {
      await _chatDB.doc(chatRoomId).delete();
    } catch (e) {
      print('deleteChat error');
    }
  }

  /* 해당 메시지 삭제하기 */
  Future deleteMessage(messageId) async {
    try {
      await _chatDB.doc(messageId).delete();
    } catch (e) {
      print('deleteChat error');
    }
  }

  /* 마지막 채팅, 최근 시간 */
  Future updateChatRoom(chatRoomId, lastContent, updatedAt) async {
    //Chat(col) - 채팅방UID(Doc)
    return await _chatDB.doc(chatRoomId).update({
      'lastContent': lastContent,
      'updatedAt': updatedAt,
    });
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

  /* 안읽은 메시지 개수 스트림으로 받기 */
  Stream unReadMessageCount(chatRoomId) {
    // final ref = _chatDB
    //     .doc(chatRoomId)
    //     .collection('message')
    //     .where('senderId', isEqualTo: _currentUid)
    //     .where('isRead', isEqualTo: 'false');
    // print(ref.snapshots().length.toString());
    // print(ref.count());
    return _chatDB
        .doc(chatRoomId)
        .collection('message')
        .where('senderId', isEqualTo: _currentUid)
        .where('isRead', isEqualTo: 'false')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => e.data() as Map<String, dynamic>));
  }
}
