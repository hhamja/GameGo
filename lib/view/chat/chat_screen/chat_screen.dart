import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

// Timestamp.now().compareTo(
//                                       _appoint.appointment['timestamp']) <
//                                   0
//                               ? _appoint.appointment['timestamp']
//                               :

class _ChatScreenPageState extends State<ChatScreenPage> {
  /* 상대유저정보 (이름, 프로필, 매너나이, uid) */
  final String userName = Get.arguments['userName'];
  final String profileUrl = Get.arguments['profileUrl'];
  final String mannerAge = Get.arguments['mannerAge'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String postId = Get.arguments['postId'];
  final PostController _post = Get.put(PostController());
  final AppointmentController _appoint = Get.put(AppointmentController());
  final ChatController _chat = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    _getAppointment();
    _post.getPostInfoByid(postId); //게시글에 대한 데이터 받기
    _chat.updateChattingWith(uid);
  }

  /* 약속날자 비동기로 받기 */
  void _getAppointment() async {
    await _appoint.getAppointment(chatRoomId);
  }

  @override
  void dispose() {
    _chat.clearUnReadCount(chatRoomId); //나의 안읽은 메시지 수 0으로 업데이트
    _chat.clearChattingWith();
    super.dispose();
  }

  Widget build(BuildContext context) {
    _getAppointment();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 20),
            ), // 상대유저이름
            SizedBox(width: 5),
            Text(
              mannerAge + '세',
              style: TextStyle(fontSize: 15),
            ), //유저 매너나이 (글씨 작게)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {Get.bottomSheet(ChatBottomSheet())}, //바텀시트호출
            icon: Icon(Icons.more_vert), //알림끄기, 차단, 신고, 나가기(red), 취소
          ),
        ],
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* 채팅에 해당하는 게시글 정보 */
            CustomPostInfo(
              postId,
              _post.postInfo['title'], //제목
              _post.postInfo['gamemode'], //게임모드
              _post.postInfo['position'], //포지션
              _post.postInfo['tear'], //티어
            ),

            /* 약속 잡는 버튼 */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  _appoint.isSetAppointment.value &&
                          _appoint.toDatetime.value.isBefore(DateTime.now())
                      ? SizedBox.shrink()
                      : Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => AppointmentPage(),
                                  arguments: {'chatRoomId': chatRoomId});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 15,
                                    Icons.calendar_month,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  /* 약속시간 > 현재 ? 약속시간 표시
                            * 약속시간 <= 현재 ?  */
                                  Text(
                                    _appoint.isSetAppointment.value
                                        ? _appoint.appointmentDate.toString()
                                        : '약속 잡기',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  // Text('약속설정')
                                ],
                              ),
                            ),
                          ),
                        ), //나중에 서비스가 커지게 되면 알림 기능 넣자

                  _appoint.isSetAppointment.value &&
                          _appoint.toDatetime.value.isBefore(DateTime.now())
                      //약속시간이 현재보다 과거 ? '후기보내기'도 표시 : 약속시간만 표시
                      ? Expanded(
                          child: InkWell(
                            onTap: () => Get.dialog(
                              CustomSmallDialog(
                                '$userName님과 게임을 하셨나요?', '취소',
                                '네, 게임했어요',
                                () => Get.back(),
                                () {
                                  Get.back();
                                  Get.to(
                                    () => SendReviewPage(),
                                    arguments: {
                                      'postId': postId, // post doc id
                                      'title': _post.postInfo['title'], //제목
                                      'gamemode':
                                          _post.postInfo['gamemode'], //게임모드
                                      'position':
                                          _post.postInfo['position'], //포지션
                                      'tear': _post.postInfo['tear'], //티어
                                      'userName': userName, //상대유저이름
                                    },
                                  );
                                }, //매너평가 페이지로 이동
                                1,
                                1,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 15,
                                    Icons.sticky_note_2_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '후기 보내기',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),

            /* 메시지 보여주는 부분 */
            Expanded(
              child: Stack(
                children: [
                  Messages(
                    chatRoomId: chatRoomId,
                    userName: userName,
                    profileUrl: profileUrl,
                    mannerAge: mannerAge,
                  ),
                ],
              ),
            ),

            /* 메시지 보내는 부분*/
            NewMessage(
              chatRoomId: chatRoomId,
              uid: uid,
            ),
          ],
        ),
      ),
    );
  }
}
