import 'package:mannergamer/utilites/index/index.dart';

class Messages extends StatefulWidget {
  /* 상대유저 이름, 프로필, 매너나이, 채팅방 id 값 */
  final String userName, profileUrl, mannerAge, chatRoomId;

  Messages({
    Key? key,
    required this.userName,
    required this.profileUrl,
    required this.mannerAge,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  /* 기기의 현재 유저 */
  final _currentUser = FirebaseAuth.instance.currentUser!;
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  var _list; // = _chat.messageList
  final _scroll = ScrollController();

  @override
  void initState() {
    _list = _chat.messageList;
    _list.bindStream(_chat.readAllMessageList(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Scrollbar(
          //색상은 ThemeData()에서  highlightColor로 변경하자
          controller: _scroll,
          thickness: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            /* 연,월,일로 메시지 그룹으로 묶기 */
            child: GroupedListView<MessageModel, String>(
              elements: _list.value,
              groupBy: (MessageModel element) => // 그룹나누는 기준
                  Jiffy(element.timestamp.toDate()).format('yyyy년 MM월 dd일'),
              groupSeparatorBuilder: (value) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              indexedItemBuilder: (context, MessageModel element, index) {
                final _time =
                    Jiffy(_list[index].timestamp.toDate()).format('HH:MM');

                print(_time);
                print(_list.length);

                /* 메시지 시간표시 조건문 */
                if (index == _list.length - 1) {
                  _chat.isDisplayTime.value = true; //리스트의 마지막 메시지
                } else if (index < _list.length - 1 &&
                    _list[index].senderId != _list[index + 1].senderId) {
                  _chat.isDisplayTime.value = true; //마지막X, 내가 보낸 메시지 그룹에서 마지막
                } else if (index < _list.length - 1 &&
                    _time !=
                        Jiffy(_list[index + 1].timestamp.toDate())
                            .format('HH:MM')) {
                  _chat.isDisplayTime.value = true; //마지막X, 다음 메시지와 시간이 달라지는 경우
                } else {
                  _chat.isDisplayTime.value = false; //나머지 경우
                }
                /* 상대 프로필 보여주는 조건문 */
                if (index >= 1 &&
                    _list[index - 1].senderId == _list[index].senderId) {
                  _chat.isShowProfile.value = false;
                } else {
                  _chat.isShowProfile.value = true;
                }
                //현재기기유저와 메시지 보낸사람의 id가 같다면 true, 아니면 false
                final bool _isMe = _currentUser.uid == _list[index].senderId;
                return _isMe
                    ?
                    /* 나의 메시지 */
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              _chat.isDisplayTime.value ? _time : '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 10,
                                  height: 3,
                                  color: Colors.grey[500]),
                            ),
                            SizedBox(width: 5),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue, //박스색상
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                key: GlobalKey(),
                                _list[index].content.toString(), //메시지 입력 리스트
                                textWidthBasis: TextWidthBasis.parent,
                                style: TextStyle(
                                  // fontFeatures: <FontFeature>[
                                  //   FontFeature.tabularFigures(),
                                  //   //폰트를 모노스페이스로 만들어주는 건데 작동을 안하네..........
                                  // ],
                                  color: Colors.grey[100],
                                ), //메시지 글 색상
                              ),
                            ),
                          ],
                        ),
                      )
                    :
                    /* 상대방 메시지 */
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _chat.isShowProfile.value
                                ? CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                      widget.profileUrl,
                                    ),
                                  ) //상대프로필
                                : SizedBox(width: 36), //빈값
                            SizedBox(width: 5),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '${_list[index].content}', //메시지 입력 리스트
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),

                            Text(
                              _chat.isDisplayTime.value ? _time : '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 10,
                                  height: 3,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
