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
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  /* 메시지 입력 칸 */
  final TextEditingController _messageController = TextEditingController();
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  /* 파베 auth 인스턴스 */
  final _currentUser = FirebaseAuth.instance.currentUser!;

  /* 입력한 메시지 DB에 보내기 */
  void _sendMessage() async {
    //현재폰유저
    UserModel peerUser =
        await _userDB.doc(_auth.currentUser!.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });
    //게시글의 유저
    UserModel postingUser = await _userDB.doc(widget.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });

    final chatRoomModel = ChatRoomModel(
      id: widget.postId + '_' + _currentUser.uid, //채팅방 id = postId_현재유저ID
      userIdList: [widget.uid, _currentUser.uid], //게시자, 현재유저 순서
      userList: [
        //게시자, 현재유저 순서
        {
          'id': postingUser.uid,
          'userName': postingUser.userName,
          'profileUrl': postingUser.profileUrl,
          'mannerAge': postingUser.mannerAge,
        },
        {
          'id': peerUser.uid,
          'userName': peerUser.userName,
          'profileUrl': peerUser.profileUrl,
          'mannerAge': peerUser.mannerAge,
        },
      ],
      lastContent: _messageController.text.trim(),
      updatedAt: Timestamp.now(),
    );
    final messageModel = MessageModel(
      timestamp: Timestamp.now(),
      isRead: false,
      content: _messageController.text.trim(),
      senderId: _currentUser.uid, //보내는 유저의 UID
    );
    _chat.createNewChatRoom(chatRoomModel); //채팅방이 이미 있다면 실행안됨
    _chat.sendNewMessege(messageModel, chatRoomModel.id);
    setState(() => _messageController.clear()); //입력한 내용 지우기
    _chat.scroll.jumpTo(0); //맨밑으로 스크롤이동 = scroll.position.maxScrollExtent
  }

  @override
  Widget build(BuildContext context) {
    print(
      '채팅방id는 ' + widget.postId + '_' + _currentUser.uid,
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
