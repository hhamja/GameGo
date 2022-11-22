import 'package:mannergamer/utilites/index/index.dart';

class ReportDialog extends StatelessWidget {
  ReportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSmallDialog(
      '신고하시겠나요?',
      '취소',
      '신고하기',
      () {
        Get.back();
      },
      () {
        Get.back();
        Timer _timer = Timer(Duration(milliseconds: 2000), () {
          Get.until((route) =>
              Get.currentRoute == '/chatscreen' ||
              Get.currentRoute == '/postdetail');
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
      1,
      1,
    );
  }
}
