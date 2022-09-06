import 'package:mannergamer/utilites/index.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(bottom: 40),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        title: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
          child: Text(
            '로그아웃',
            textAlign: TextAlign.center,
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '로그아웃 하시겠나요?',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
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
              Expanded(
                flex: 5,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Text(
                    '확인',
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
