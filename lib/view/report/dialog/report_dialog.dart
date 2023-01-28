import 'package:mannergamer/utilites/index/index.dart';

class ReportDialog extends StatefulWidget {
  ReportDialog({Key? key}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final ReportController _report = Get.put(ReportController());
  var reportContent = Get.arguments['content']; //신고 내용
  var postId = Get.arguments['postId']; //채팅방에서 신고한 경우 "null"
  var chatRoomId = Get.arguments['chatRoomId']; //게시글에서 신고한 경우 "null"
  var uid = Get.arguments['uid']; //신고 받는 uid

  @override
  Widget build(BuildContext context) {
    return CustomSmallDialog(
      // 내용
      '신고하시겠나요?',
      //왼쪽 버튼 텍스트
      '취소',
      //오른쪽 버튼 텍스트
      '신고하기',
      //왼쪽 버튼 클릭 시
      () => Get.back(),
      //오른쪽 버튼 클릭 시
      () async {
        // 신고 model 인스턴스
        final ReportModel _model = await ReportModel(
          idFrom: CurrentUser.uid,
          idTo: uid,
          postId: postId,
          chatRoomId: chatRoomId,
          reportContent: reportContent,
          createdAt: Timestamp.now(),
        );
        //신고데이터 DB에 보내기
        await _report.addUserReport(_model);
        Get.back();
        // 신고해줘서 고맙다는 간단한 알림을 유저에게 보여준 다음
        // 2초 후, 채팅방에서 신고한 경우 : 채팅방, 게시글에서 신고한 경우 : 게시글로 이동
        Timer _timer = Timer(Duration(milliseconds: 2000), () {
          Get.until((route) =>
              Get.currentRoute == '/chatscreen' ||
              Get.currentRoute == '/postdetail' ||
              Get.currentRoute == '/noUserChatScreen');
        });
        Get.dialog(
            barrierDismissible: true,
            AlertDialog(
              title: Text(
                '따뜻한 매너게이머를 위한\n신고 감사합니다.',
                textAlign: TextAlign.center,
              ),
            )).then((value) {
          if (_timer.isActive) {
            _timer.cancel();
          }
        });
      },
      //왼쪽, 오른쪽 버튼 비율 1:1
      1,
      1,
    );
  }
}
