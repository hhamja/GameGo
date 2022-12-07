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
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  final AppointmentController _appoint = Get.put(AppointmentController());
  /* 기기의 현재 유저 */
  final _currentUid = FirebaseAuth.instance.currentUser!.uid;
  var _list; // = _chat.messageList

  @override
  void initState() {
    super.initState();
    _list = _chat.messageList;
    _list.bindStream(_chat.readAllMessageList(widget.chatRoomId));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      /* 스크롤 바 */
      () => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Scrollbar(
          controller: _chat.scroll,
          interactive: true,
          thickness: 3, //색상은 ThemeData()에서  highlightColor로 변경하자
          /* 채팅리스트 박스의 패딩 */
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              controller: _chat.scroll,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                int reversed = _list.length - 1 - index;
                final _date = Jiffy(_list[reversed].timestamp.toDate())
                    .format('yyyy년 MM월 dd일'); //현재 index에 대한 날짜
                final _time = Jiffy(_list[reversed].timestamp.toDate())
                    .format('HH:MM'); //22시간
                /* Date표시에 대한 조건 */
                if (reversed == 0) {
                  _chat.isShowDate.value = true; //첫 메시지이면 O
                } else if (reversed != 0 &&
                    Jiffy(_list[reversed - 1].timestamp.toDate())
                            .format('yyyy년 MM월 dd일') !=
                        _date) {
                  _chat.isShowDate.value = true; //날짜가 달라지면 O
                } else {
                  _chat.isShowDate.value = false; //나머지는 X
                }
                /* 메시지 시간표시 조건 */
                if (reversed == _list.length - 1) {
                  _chat.isShowTime.value = true; //리스트의 마지막 메시지
                } else if (reversed < _list.length - 1 &&
                    _list[reversed].idFrom != _list[reversed + 1].idFrom) {
                  _chat.isShowTime.value = true; //마지막X, 내가 보낸 메시지 그룹에서 마지막
                } else if (reversed < _list.length - 1 &&
                    _time !=
                        Jiffy(_list[reversed + 1].timestamp.toDate())
                            .format('HH:MM')) {
                  _chat.isShowTime.value = true; //마지막X, 다음 메시지와 시간이 달라지는 경우
                } else {
                  _chat.isShowTime.value = false; //나머지 경우
                }
                /* 상대 프로필 보여주는 조건문 
                * 첫번째 메시지라면? 프로필 표시 O
                * 첫번째 메시지가 아니고 이전 메시지와 현재메시지의 사람이 같고 날짜(시간X)도 같다면? 프로필 표시 X */
                if (reversed == 0) {
                  _chat.isShowProfile.value = true;
                } else if (_list[reversed - 1].idFrom ==
                        _list[reversed].idFrom &&
                    Jiffy(_list[reversed - 1].timestamp.toDate())
                            .format('yyyy년 MM월 dd일') ==
                        _date) {
                  _chat.isShowProfile.value = false;
                } else {
                  _chat.isShowProfile.value = true;
                }
                //현재기기유저와 메시지 보낸사람의 id가 같다면 true, 아니면 false
                final bool _isMe = _currentUid == _list[reversed].idFrom;
                return _isMe
                    ?
                    /* 나의 메시지 */
                    Column(
                        children: [
                          _chat.isShowDate.value
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    _date.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : SizedBox.shrink(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  _chat.isShowTime.value ? _time : '',
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(
                                    _list[reversed]
                                        .content
                                        .toString(), //메시지 입력 리스트
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
                          ),
                        ],
                      )
                    :
                    /* 상대방 메시지 */
                    Column(
                        children: [
                          _chat.isShowDate.value
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    _date.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : SizedBox.shrink(),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(
                                    '${_list[reversed].content}', //메시지 입력 리스트
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  _chat.isShowTime.value ? _time : '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 10,
                                      height: 3,
                                      color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
            // Padding(
            //     padding: EdgeInsets.all(
            //         MediaQuery.of(context).viewInsets.bottom))
          ),
        ),
      ),
    );
  }
}
