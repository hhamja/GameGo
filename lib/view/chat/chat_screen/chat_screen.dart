import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  // 상대유저정보 (이름, 프로필, uid)
  final String userName = Get.arguments['userName'] ?? '';
  final String profileUrl = Get.arguments['profileUrl'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String postId = Get.arguments['postId'];
  final PostController _post = Get.put(PostController());
  final EvaluationController _evaluation = Get.put(EvaluationController());
  final AppointmentController _appoint = Get.put(AppointmentController());
  final ChatController _chat = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    // 약속날자 비동기로 받기
    _getAppointment();
    // 게시글에 대한 데이터 받기
    _post.getPostInfoByid(postId);
    // 상대 유저에 대한 매너나이 받기
    _chat.getUserMannerAge(uid);
    // 현재 채팅하는 상대가 누군지 업데이트
    _chat.updateChattingWith(uid);
    // 보낸 리뷰가 존재하는지 여부
    _evaluation.checkExistEvaluation(uid, chatRoomId);
  }

  // 약속날자 비동기로 받기
  void _getAppointment() async {
    await _appoint.getAppointment(chatRoomId);
  }

  @override
  void dispose() {
    // 나의 안읽은 메시지 수 0으로 업데이트
    _chat.clearUnReadCount(chatRoomId);
    // 채팅하는 상대에 대한 정보 지우기
    _chat.clearChattingWith();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getAppointment();
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.toNamed(
              '/userProfile',
              // 상대 데이터 전달
              arguments: {
                'profileUrl': profileUrl,
                'userName': userName,
                'mannerAge': _chat.mannerAge.value,
                'uid': uid,
              },
            );
          },
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(width: 3.sp),
              // 매너나이
              Text(
                '${_chat.mannerAge.value}세',
                style: TextStyle(
                  fontSize: 10.sp,
                  letterSpacing: 0.25.sp,
                  color: mannerAgeColor,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              Get.bottomSheet(
                ChatBottomSheet(
                  chatRoomId: chatRoomId,
                  //신고받은 uid
                  uid: uid,
                ),
              ),
            },
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 게시글 정보
            Opacity(
              // 삭제된 게시글은 투명하게
              opacity: _post.postInfo.isDeleted ? 0.3 : 1,
              child: CustomPostInfo(
                postId,
                _post.postInfo.isDeleted
                    // 삭제 게시글
                    ? '${_post.postInfo.title} (삭제됨)'
                    // 비 삭제 게시글
                    : _post.postInfo.title,
                _post.postInfo.gamemode,
                _post.postInfo.position,
                _post.postInfo.tear,
                // 게시글 박스 클릭 시
                () => _post.postInfo.isDeleted
                    // 삭제 게시글의 경우
                    ? null
                    // 삭제 게시글이 아닌
                    : Get.toNamed(
                        '/postdetail',
                        arguments: {'postId': postId},
                      ),
              ),
            ),
            // 약속 잡는 버튼
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
              child: Row(
                children: [
                  _appoint.isSetAppointment.value &&
                          _appoint.toDatetime.value.isBefore(DateTime.now())
                      ? SizedBox.shrink()
                      : Expanded(
                          child: InkWell(
                            // 상대방이 보낸 메시지
                            onTap: _chat.messageList
                                            .where((element) =>
                                                element.idFrom == uid)
                                            .length !=
                                        0 &&
                                    _chat.messageList
                                            .where((element) =>
                                                element.idFrom ==
                                                CurrentUser.uid)
                                            .length !=
                                        0
                                ?
                                // 있다면? 약속설정 가능 O
                                () {
                                    Get.to(() => AppointmentPage(), arguments: {
                                      'chatRoomId': chatRoomId,
                                      'uid': uid,
                                      'postId': postId,
                                      'postTitle': _post.postInfo.title,
                                    });
                                  }
                                // 없다면? 약속설정 X , 토스트 사용자에게 알림
                                : () {
                                    Get.snackbar(
                                      '',
                                      '',
                                      titleText: Text(
                                        '약속설정불가',
                                        style: AppTextStyle.snackbarTitleStyle,
                                      ),
                                      messageText: Text(
                                        '상대방도 메시지를 보내면 약속을 잡을 수 있어요.',
                                        style:
                                            AppTextStyle.snackbarContentStyle,
                                      ),
                                    );
                                  },
                            child: Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8.sp, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 12.sp,
                                    Icons.calendar_month,
                                    color: appBlackColor,
                                  ),
                                  SizedBox(width: 3.sp),
                                  // 약속시간 > 현재 ? 약속시간 표시
                                  // 약속시간 <= 현재 ?
                                  Text(
                                    _appoint.isSetAppointment.value
                                        ? _appoint.appointmentDate.toString()
                                        : '약속 잡기',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  _appoint.isSetAppointment.value &&
                          _appoint.toDatetime.value.isBefore(DateTime.now())
                      // 약속시간이 현재보다 과거 ? '후기보내기'도 표시 : 약속시간만 표시
                      ? Expanded(
                          child: _evaluation.isExistEvaluation.value
                              ? // 이미 보낸 후기가 있는 경우
                              InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => MySentReviewPage(),
                                      arguments: {
                                        // 상대 uid, 닉네임, 채팅방 id
                                        'uid': uid,
                                        'userName': userName,
                                        'chatRoomId': chatRoomId,
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4.sp),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.8.sp, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          size: 12.sp,
                                          Icons.sticky_note_2_outlined,
                                          color: appBlackColor,
                                        ),
                                        SizedBox(width: 3.sp),
                                        Text(
                                          '보낸 후기 확인하기',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : // 이미 보낸 후기가 없는 경우
                              InkWell(
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
                                            'uid': uid, //상대 uid
                                            'chatRoomId': chatRoomId, //채팅방 id
                                            'postTitle':
                                                _post.postInfo.title, //게시글 제목
                                            'postId': postId, //게시글 id
                                            'userName': userName, //상대유저이름
                                          },
                                        );
                                      }, //매너평가 페이지로 이동
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(4.sp),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.8.sp, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          size: 12.sp,
                                          Icons.sticky_note_2_outlined,
                                          color: appBlackColor,
                                        ),
                                        SizedBox(width: 3.sp),
                                        Text(
                                          '후기 보내기',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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

            // 메시지 보여주는 부분
            Expanded(
              child: Stack(
                children: [
                  Messages(
                    chatRoomId: chatRoomId,
                    userName: userName,
                    profileUrl: profileUrl,
                  ),
                ],
              ),
            ),
            // 메시지 보내기
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
