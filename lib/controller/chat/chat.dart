import 'package:mannergamer/utilites/index/index.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  // 채팅방에서 상대방 매너Lv
  Rx<MannerLevelModel> mannerLevel = MannerLevelModel(
    mannerLevel: '',
    levelExp: '',
  ).obs;

  String get level => mannerLevel.value.mannerLevel;

  @override
  void onInit() {
    super.onInit();
    // 채팅방리스트 스트림으로 받기
    chatRoomList.bindStream(readAllChatList());
    scroll;
  }

  @override
  void onClose() {
    // 채팅페이지의 스크롤 끄기
    scroll.dispose();
    super.onClose();
  }

  // 채팅 상대방의 매너Lv 데이터 받기
  Future getUserMannerLevel(uid) async {
    await _userDB.doc(uid).get().then(
        (e) => mannerLevel.value = MannerLevelModel.fromDocumentSnapshot(e));
  }

  // 새로운 채팅 입력 시 채팅방 생성하기
  Future createNewChatRoom(ChatRoomModel chatRoomModel) async {
    // 채팅방이 존재하지 않는다면? chat col에 채팅방 데이터 추가
    final res = await _chatDB.doc(chatRoomModel.chatRoomId).get();
    if (!res.exists)
      // Chat(col) - 채팅방UID(Doc)
      await _chatDB.doc(chatRoomModel.chatRoomId).set(
        {
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
        },
      );
  }

  // 새로운 채팅 입력 시 서버에 추가
  Future sendNewMessege(MessageModel messageModel, chatRoomId) async {
    // 메시지 컬렉션에 추가
    _chatDB.doc(chatRoomId).collection('message').add(
      {
        'content': messageModel.content,
        'idFrom': messageModel.idFrom,
        'idTo': messageModel.idTo,
        'type': messageModel.type,
        'isDeleted': messageModel.isDeleted,
        'timestamp': messageModel.timestamp,
      },
    );
    // 상대 uid의 unReadCount +1
    _chatDB.doc(chatRoomId).update(
      {
        'unReadCount.${messageModel.idTo}': FieldValue.increment(1),
      },
    );
  }

  // 모든 '채팅' 리스트 스트림으로 받기
  Stream<List<ChatRoomModel>> readAllChatList() async* {
    yield* _chatDB
        .where('members', arrayContains: _auth.currentUser!.uid)
        .orderBy('updatedAt', descending: true) //최신이 맨 위
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => ChatRoomModel.fromDocumentSnapshot(e),
              )
              .toList(),
        );
  }

  // 모든 '메시지' 리스트 스트림으로 받기
  Stream<List<MessageModel>> readAllMessageList(chatRoomId) async* {
    yield* _chatDB
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (e) => MessageModel.fromDocumentSnapshot(e),
            )
            .toList());
  }

  // 메시지를 보낼 때 마다 마지막 채팅, 최근 시간 업데이트
  Future updateChatRoom(members, chatRoomId, lastContent, updatedAt) async {
    return _chatDB.doc(chatRoomId).update(
      {'members': members, 'lastContent': lastContent, 'updatedAt': updatedAt},
    );
  }

  // 메시지페이지를 나갔을 때 나의 안읽은 메시지 수 0으로 업데이트
  Future clearUnReadCount(chatRoomId) async {
    final chatRoomRef = await _chatDB.doc(chatRoomId).get();
    chatRoomRef.exists
        ?
        // 나의 안읽은메시지 수 0으로 업데이트
        _chatDB.doc(chatRoomId).update({
            'unReadCount.${_auth.currentUser!.uid}': 0,
          })
        : null;
  }

  //채팅페이지 들어가면, chattingWith 상대 uid로 업데이트
  Future updateChattingWith(uid) async {
    await _userDB.doc(_auth.currentUser!.uid).update(
      {'chattingWith': uid},
    );
  }

  // 채팅페이지에서 나가면, chattingWith 빈값으로 업데이트
  Future clearChattingWith() async {
    await _userDB.doc(_auth.currentUser!.uid).update(
      {'chattingWith': null},
    );
  }
}
