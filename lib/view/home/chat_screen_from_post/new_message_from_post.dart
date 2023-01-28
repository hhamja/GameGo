import 'package:mannergamer/utilites/index/index.dart';

class NewMessageFromPost extends StatefulWidget {
  final String uid; // 게시글 유저 uid
  final String postId; //게시물 id
  NewMessageFromPost({Key? key, required this.uid, required this.postId})
      : super(key: key);

  @override
  State<NewMessageFromPost> createState() => _NewMessageFromPostState();
}

class _NewMessageFromPostState extends State<NewMessageFromPost> {
  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 메시지 입력 칸 */
  final TextEditingController _messageController = TextEditingController();
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.find<ChatController>();

  /* 입력한 메시지 DB에 보내기 */
  void _sendMessage() async {
    // 게시자(=postingUser) 인스턴스
    final UserModel postingUser =
        await _userDB.doc(widget.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });
    // 현재유저정보(=contactUser) 인스턴스
    final UserModel contactUser =
        await _userDB.doc(CurrentUser.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });
    // 채팅방 인스턴스
    final ChatRoomModel chatRoomModel = ChatRoomModel(
      //채팅방 id = postId_현재유저ID
      chatRoomId: widget.postId + '_' + CurrentUser.uid,
      postId: widget.postId,
      members: [
        postingUser.uid,
        contactUser.uid,
      ], //postingUser, contactUser 순으로 넣기
      postingUid: postingUser.uid,
      postingUserProfileUrl: postingUser.profileUrl,
      postingUserName: postingUser.userName,
      contactUid: contactUser.uid,
      contactUserProfileUrl: contactUser.profileUrl,
      contactUserName: contactUser.userName,
      //읽지않은 메시지를 '보낸'Uid와 그 수 {게시자 : 0, 상대유저 : 0}
      unReadCount: {
        postingUser.uid: 0,
        contactUser.uid: 0,
      },
      lastContent: _messageController.text.trim(),
      isActive: false,
      updatedAt: Timestamp.now(),
    );
    // 메시지 인스턴스 생성
    final MessageModel messageModel = MessageModel(
      timestamp: Timestamp.now(),
      content: _messageController.text.trim(),
      idFrom: CurrentUser.uid,
      idTo: widget.uid,
      type: 'message',
    );
    // 채팅방 만들기, 채팅방이 이미 있다면 실행안됨
    await _chat.createNewChatRoom(chatRoomModel);
    // 보낸 메시지 파이어스토어 message 컬렉션에 저장하기
    await _chat.sendNewMessege(
        messageModel, chatRoomModel.chatRoomId, widget.uid);
    // 메시지 텍스트필드 초기화
    setState(() => _messageController.clear());
    // 보낸 메시지로 화면이동
    // 0인이유 : Listview.builder의 reverse가 true이므로 Top과 Bottom이 반전됨
    _chat.scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    print(
      '채팅방id는 ' + widget.postId + '_' + CurrentUser.uid,
    );
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 0, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // IconButton(
          //   onPressed: () {}, //클릭 시 사진보내기 (나중)
          //   icon: Icon(
          //     Icons.add_sharp,
          //     size: 30,
          //     color: Colors.grey[500],
          //   ),
          // ),
          /* 메시지 입력란 */
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 40,
              ),
              child: TextField(
                // key: _messageKey,
                autocorrect: false,
                controller: _messageController,
                keyboardType: TextInputType.text,
                maxLines: null,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none),
                  hintText: '메시지 보내기',
                  hintStyle: TextStyle(height: 0.0005, color: Colors.grey[400]),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          /* 보내기 버튼 */
          IconButton(
            alignment: Alignment.center,
            onPressed: _messageController.text.trim().isEmpty
                ? null // 메시지 아무것도 입력되어 있지 않으면 버튼 작동 X
                : _sendMessage, //클릭 시 chat DB에 입력 데이터 보냄
            icon: Icon(
              Icons.send,
              color: _messageController.text.trim().isNotEmpty
                  ? Colors.blue //입력하는 순간 아이콘 블루 색
                  : Colors.grey[400], // 텍스트 입력 x -> 그레이 색
            ),
          ),
        ],
      ),
    );
  }
}
