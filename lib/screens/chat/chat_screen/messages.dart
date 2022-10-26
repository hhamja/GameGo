import 'package:mannergamer/utilites/index/index.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Messages extends StatefulWidget {
  /* 상대유저 이름, 프로필, 매너나이 */
  final String userName, profileUrl, mannerAge;
  /* 채팅방 id 값 */
  final String chatRoomId;

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

  @override
  void initState() {
    _chat.messageList.bindStream(_chat.readAllMessageList(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        /* 연,월,일로 메시지 그룹으로 묶기 */
        child: GroupedListView<MessageModel, String>(
          elements: _chat.messageList.value, //value 안 붙이면 에러나옴
          groupBy: (MessageModel element) => Jiffy(element.timestamp.toDate())
              .format('yyyy년 MM월 dd일'), //년,월,일로 그룹나눔
          groupSeparatorBuilder: (value) {
            return Text(
              value.toString(),
              textAlign: TextAlign.center,
            );
          },
          indexedItemBuilder: (context, MessageModel element, index) {
            // // //날짜표시 bool값 -> 다음 시간이 지금 표시되는 시간과 달라야 지금표시

            //     Jiffy(_chat.messageList[index].timestamp.toDate())
            //             .format('a HH:mm') !=
            //         Jiffy(_chat.messageList[index + 1].timestamp.toDate())
            //             .format('a h:mm'); //다르면 true
            // print(_isShowTime);
            print(Jiffy(element.timestamp.toDate()).format('a HH:MM'));
            //이전 id와 현재 id 비교하여 bool반환
            if (index > 1 &&
                _chat.messageList[index - 1].senderId ==
                    _chat.messageList[index].senderId) {
              _chat.isShowProfile.value = false;
            } else {
              _chat.isShowProfile.value = true;
            }

            //현재기기유저와 메시지 보낸사람의 id가 같다면 true, 아니면 false
            final bool _isMe =
                _currentUser.uid == _chat.messageList[index].senderId;
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: DrawerMotion(),
                children: [
                  /* 시간표시 */
                  SlidableAction(
                    onPressed: null,
                    autoClose: true,
                    padding: EdgeInsets.zero,
                    label: Jiffy(_chat.messageList[index].timestamp.toDate())
                        .format('a HH:MM')
                        .toString(),
                  ),
                ],
              ),
              child: _isMe
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
                            '오후 12:42',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 10,
                                height: 3,
                                color: Colors.grey[500]),
                          ),
                          SizedBox(width: 5),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue, //박스색상
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: Text(
                              _chat.messageList[index].content
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
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    widget.profileUrl,
                                  ),
                                ) //상대프로필
                              : SizedBox(width: 30), //빈값
                          SizedBox(width: 5),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
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
                            '',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 10,
                                height: 3,
                                color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
