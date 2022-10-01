import 'package:mannergamer/utilites/index.dart';

class ChatController extends GetxController {
  /* 파이어스토어 Chat 컬렉션 참조 instance */
  final CollectionReference _chat =
      FirebaseFirestore.instance.collection('chat');

  /* RxList chatList [] 선언 */
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    messageList.bindStream(readAllMessage());
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Add Message To DB */
  Future addMessageToDB(MessageModel messagemodel) async {
    try {
      await _chat.add({
        'messageText': messagemodel.messageText,
        'senderId': messagemodel.senderId,
        'recieverId': messagemodel.recieverId,
        'dateTime': messagemodel.dateTime,
      });
    } catch (e) {
      print('addMessageToDB error');
    }
  }

  /* Stream Read Message */
  Stream<List<MessageModel>> readAllMessage() {
    return _chat
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return MessageModel.fromDocumentSnapshot(e);
            }).toList());
  }
}
