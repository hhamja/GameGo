import 'dart:ui';
import 'package:mannergamer/utilites/index/index.dart';

class MessagesFromPost extends StatefulWidget {
  /* 게시글 유저의  UID, 게시물 id 값, 상대프로필 */
  final String uid, postId, profileUrl;
  MessagesFromPost(
      {Key? key,
      required this.uid,
      required this.postId,
      required this.profileUrl})
      : super(key: key);

  @override
  State<MessagesFromPost> createState() => _MessagesFromPostState();
}

class _MessagesFromPostState extends State<MessagesFromPost> {
  /* 기기의 현재 유저 */
  final _currentUser = FirebaseAuth.instance.currentUser!;
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  @override
  void initState() {
    _chat.messageList.bindStream(
        _chat.readAllMessageList(widget.postId + '_' + _currentUser.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        controller: ScrollController(),
        itemCount: _chat.messageList.length,
        itemBuilder: (context, index) {
          //현재기기유저와 메시지 보낸사람의 id가 같다면 true, 아니면 false
          final bool _isMe =
              _currentUser.uid == _chat.messageList[index].senderId;
          return _isMe
              ? /* 나의 메시지 */
              Container(
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '오후 1:32',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, height: 3, color: Colors.grey[500]),
                      ),
                      SizedBox(width: 5),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue, //박스색상
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Text(
                          _chat.messageList[index].content
                              .toString(), //메시지 입력 리스트
                          textWidthBasis: TextWidthBasis.parent,
                          style: TextStyle(
                            fontFeatures: <FontFeature>[
                              FontFeature
                                  .tabularFigures(), //폰트를 모노스페이스로 만들어주는 건데 작동을 안하네..........
                            ],
                            color: Colors.grey[100],
                          ), //메시지 글 색상
                        ),
                      ),
                    ],
                  ),
                )
              : /* 상대방 메시지 */
              Container(
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                          widget.profileUrl,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '${_chat.messageList[index].content}', //메시지 입력 리스트
                            textWidthBasis: TextWidthBasis.parent,
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '오후 1:32',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, height: 3, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
