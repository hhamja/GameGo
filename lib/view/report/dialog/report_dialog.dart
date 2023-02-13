import 'package:mannergamer/utilites/index/index.dart';

class ReportDialog extends StatefulWidget {
  ReportDialog({Key? key}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ReportController _report = Get.put(ReportController());
  var reportContent = Get.arguments['content'];
  // 채팅방에서 신고한 경우 null
  var postId = Get.arguments['postId'];
  // 게시글에서 신고한 경우 null
  var chatRoomId = Get.arguments['chatRoomId'];
  // 신고 받는 uid
  var uid = Get.arguments['uid'];

  @override
  Widget build(BuildContext context) {
    return CustomSmallDialog(
      '신고하시겠나요?',
      '취소',
      '신고하기',
      () => Get.back(),
      () async {
        final ReportModel _model = await ReportModel(
          idFrom: _auth.currentUser!.uid,
          idTo: uid,
          postId: postId,
          chatRoomId: chatRoomId,
          reportContent: reportContent,
          createdAt: Timestamp.now(),
        );
        // 신고 데이터 서버에 보내기
        await _report.addUserReport(_model);
        // 다이얼로그 내리기
        Get.back();
        // 신고해줘서 고맙다는 간단한 알림을 유저에게 보여준 다음
        // 2초 후, 채팅방에서 신고한 경우 : 채팅방, 게시글에서 신고한 경우 : 게시글로 이동
        Timer _timer = Timer(
          Duration(milliseconds: 2000),
          () {
            Get.until((route) =>
                // 채팅에서 신고한 경우
                Get.currentRoute == '/chatscreen' ||
                // 게시글에서 신고한 경우
                Get.currentRoute == '/postdetail' ||
                // 탈퇴유저 채팅페이지에서 신고한 경우
                Get.currentRoute == '/noUserChatScreen');
          },
        );
        Get.dialog(
          barrierDismissible: true,
          AlertDialog(
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            title: Text(
              '매너있는 ${appName}를 위한 신고\n감사합니다.',
              textAlign: TextAlign.left,
            ),
          ),
        ).then(
          (value) {
            if (_timer.isActive) {
              _timer.cancel();
            }
          },
        );
      },
    );
  }
}
