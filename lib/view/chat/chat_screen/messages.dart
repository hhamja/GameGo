import 'package:mannergamer/utilites/index/index.dart';

class Messages extends StatefulWidget {
  // 상대유저 이름, 기본프로필, 채팅방 id 값
  final String userName, profileUrl, chatRoomId;

  Messages({
    Key? key,
    required this.userName,
    required this.profileUrl,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final ChatController _chat = Get.put(ChatController());
  // _chat.messageList
  var _list;

  @override
  void initState() {
    super.initState();
    _list = _chat.messageList;
    _list.bindStream(_chat.readAllMessageList(widget.chatRoomId));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      // 스크롤 바
      () => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Scrollbar(
          controller: _chat.scroll,
          interactive: true,
          // 색상은 ThemeData()에서  highlightColor로 변경하자
          thickness: 3,
          // 채팅리스트 박스의 패딩
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              controller: _chat.scroll,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                int reversed = _list.length - 1 - index;
                // 현재 index에 대한 날짜
                final _date = Jiffy(_list[reversed].timestamp.toDate())
                    .format('yyyy년 MM월 dd일');
                // 24시간
                final _time =
                    Jiffy(_list[reversed].timestamp.toDate()).format('HH:MM');
                // Date표시에 대한 조건
                if (reversed == 0) {
                  // 첫 메시지
                  _chat.isShowDate.value = true;
                } else if (reversed != 0 &&
                    Jiffy(_list[reversed - 1].timestamp.toDate())
                            .format('yyyy년 MM월 dd일') !=
                        _date) {
                  // 날짜가 달라지면
                  _chat.isShowDate.value = true;
                } else {
                  _chat.isShowDate.value = false;
                }
                // 메시지 시간표시 조건
                if (reversed == _list.length - 1) {
                  // 리스트의 마지막 메시지
                  _chat.isShowTime.value = true;
                } else if (_list[reversed].idFrom !=
                    _list[reversed + 1].idFrom) {
                  // 마지막X, 내가 보낸 메시지 그룹에서 마지막
                  _chat.isShowTime.value = true;
                } else if (_time !=
                    Jiffy(_list[reversed + 1].timestamp.toDate())
                        .format('HH:MM')) {
                  // 마지막X, 다음 메시지와 시간이 달라지는 경우
                  _chat.isShowTime.value = true;
                } else {
                  _chat.isShowTime.value = false;
                }

                //상대 프로필 보여주는 조건문
                //첫번째 메시지라면? 프로필 표시 O
                //첫번째 메시지가 아니고 이전 메시지와 현재메시지의 사람이 같고 날짜(시간X)도 같다면? 프로필 표시 X
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
                // 내가 보낸 메시지인지에 대한 bool 값
                final bool _isMe = _list[reversed].idFrom == CurrentUser.uid;
                // 메시지 타입에 대한 bool값
                final bool _appointType = _list[reversed].type == 'appoint';
                // 나와 상대방 메시지 간격 주기 위한 bool 변수
                var isChangeUser;
                if (reversed > 0 &&
                    _list[reversed].idFrom != _list[reversed - 1].idFrom) {
                  isChangeUser = true;
                } else
                  isChangeUser = false;

                return _isMe
                    ? // 나의 메시지
                    Container(
                        margin: isChangeUser
                            ? EdgeInsets.only(top: 10)
                            : EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          children: [
                            _chat.isShowDate.value
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      _date.toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : SizedBox.shrink(),
                            !_appointType
                                ? // 메시지 타입인 경우
                                Row(
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
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xff6843F9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        // 메시지 입력 리스트
                                        child: Text(
                                          _list[reversed].content.toString(),
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: TextStyle(
                                            color: Colors.grey[100],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      _list[reversed].content.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ],
                        ),
                      )
                    : // 상대방 메시지
                    Container(
                        margin: isChangeUser
                            ? EdgeInsets.only(top: 10)
                            : EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          children: [
                            _chat.isShowDate.value
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      _date.toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : SizedBox.shrink(),
                            !_appointType
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      //상대프로필
                                      _chat.isShowProfile.value
                                          ? CircleAvatar(
                                              radius: 18,
                                              backgroundImage: NetworkImage(
                                                widget.profileUrl,
                                              ),
                                            )
                                          : SizedBox(width: 36),
                                      SizedBox(width: 5),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        // 메시지 입력 리스트
                                        child: Text(
                                          '${_list[reversed].content}',
                                          textWidthBasis: TextWidthBasis.parent,
                                          style:
                                              TextStyle(color: appBlackColor),
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
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      _list[reversed].content.toString(),
                                      textAlign: TextAlign.center,
                                    ),
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
