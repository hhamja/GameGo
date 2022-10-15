import 'package:mannergamer/utilites/index.dart';

class ChatController extends GetxController {
  /* 파이어스토어 Chat 컬렉션 참조 */
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  /* 파이어스토어 User 컬렉션 참조 */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 채팅하고 있는 유저의 채팅리스트 담는 RxList 변수 */
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  /* 채팅방안의 모든 메시지 담는 RxList 변수 */
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  /* 현재 유저의 uid */
  final _currentUid = FirebaseAuth.instance.currentUser?.uid.toString();

  @override
  void onInit() {
    //현재유저의 채팅리스트 스트림으로 받기
    chatRoomList.bindStream(readAllChatList(_currentUid));
    super.onInit();
  }

  /* 새로운 채팅 입력 시 메시지DB 추가 */
  Future sendNewMessege(MessageModel messageModel, chatRoomId) async {
    try {
      //채팅(col) - 그룹UID(Doc) - 메시지(Col) - 메시지내용()
      await _chatDB.doc(chatRoomId).collection('message').add({
        'content': messageModel.content,
        'senderId': messageModel.senderId,
        'timestamp': messageModel.timestamp,
      });
    } catch (e) {
      print('sendNewMessege error');
    }
  }

  /* 새로운 채팅 입력 시 채팅방 생성하기 */
  Future createNewChatRoom(ChatRoomModel chatRoomModel) async {
    try {
      //Chat(col) - 채팅방UID(Doc)
      await _chatDB.doc(chatRoomModel.id).set({
        'id': chatRoomModel.id,
        'userIdList': chatRoomModel.userIdList,
        'lastContent': chatRoomModel.lastContent,
        'postingUserId': chatRoomModel.postingUserId,
        'peerUserId': chatRoomModel.peerUserId,
        'updatedAt': chatRoomModel.updatedAt,
      });
    } catch (e) {
      print('createNewChatRoom error');
    }
  }

  /* 모든 '채팅' 리스트 스트림으로 받기 */
  Stream<List<ChatRoomModel>> readAllChatList(currentUid) {
    return _chatDB
        .where('userIdList', arrayContains: currentUid)
        .orderBy('updatedAt', descending: true) //최신이 맨 위s
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

  /* 채팅 업데이트 */
  Future updatechat(MessageModel messageModel) async {
    try {
      await _chatDB.doc(messageModel.id).update({
        'content': messageModel.content,
        'senderId': messageModel.senderId,
        'timestamp': messageModel.timestamp,
      });
    } catch (e) {
      print('updatechat error');
    }
  }

  /* 채팅 삭제하기 */
  //일단 후순위로 미루자
  Future deleteChat(chatId) async {
    try {
      await _chatDB.doc(chatId).delete();
    } catch (e) {
      print('deleteChat error');
    }
  }
  // Stream<QuerySnapshot> getChatList(String chatId) {
  //   return _chatDB
  //       .doc(chatId)
  //       .collection('message')
  //       .orderBy('timestamp', descending: true) //최신이 맨위
  //       .snapshots();
  // }
}
