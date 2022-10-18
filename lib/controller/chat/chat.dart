import 'package:mannergamer/utilites/index/index.dart';

class ChatController extends GetxController {
  /* 파이어스토어 Chat 컬렉션 참조 */
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  /* 파이어스토어 User 컬렉션 참조 */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('chat');
  /* 채팅하고 있는 유저의 채팅리스트 담는 RxList 변수 */
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  /* 채팅방안의 모든 메시지 담는 RxList 변수 */
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  /* 현재 유저의 uid */
  final _currentUid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void onInit() {
    //현재유저의 채팅리스트 스트림으로 받기
    chatRoomList.bindStream(readAllChatList(_currentUid));
    super.onInit();
  }

/* 새로운 채팅 입력 시 채팅방 생성하기 */
  Future createNewChatRoom(ChatRoomModel chatRoomModel) async {
    final res = await _chatDB.doc(chatRoomModel.id).get();
    //채팅방이 존재하지 않는다면? 새로운 채팅방 만듬
    if (!res.exists)
      //Chat(col) - 채팅방UID(Doc)
      await _chatDB.doc(chatRoomModel.id).set({
        'id': chatRoomModel.id,
        'userIdList': chatRoomModel.userIdList,
        'userList': chatRoomModel.userList,
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
      'timestamp': messageModel.timestamp,
    });
  }

  /* 모든 '채팅' 리스트 스트림으로 받기 */
  Stream<List<ChatRoomModel>> readAllChatList(currentUid) {
    return _chatDB
        .where('userIdList', arrayContains: currentUid)
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

  getUserById(uid) async {
    await _userDB.doc(uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });
  }
}
