import 'package:mannergamer/utilites/index/index.dart';

class ReportDialog extends StatelessWidget {
  ReportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(vertical: 30),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '신고하시겠나요?',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /* 취소 */
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              /* 신고하기 */
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
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
                  child: Text(
                    '신고하기',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
