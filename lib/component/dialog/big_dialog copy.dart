import 'package:mannergamer/utilites/index/index.dart';

class CustomBigDialog extends StatelessWidget {
  CustomBigDialog(this.title, this.content, this.cancelText, this.completeText,
      this.cancelFun, this.completeFun, this.cancelFlex, this.completeFlex);

  final String title; //제목
  final String content; //내용
  final String cancelText; //왼쪽 버튼 내용, ex)취소
  final String completeText; //오른쪽 버튼 내용, ex)확인
  final Function() cancelFun; //취소버튼의 onPressed()
  final Function() completeFun; //완료버튼의 onPressed()
  /* cancelFlex : completeFlex = 1:1이면 버튼 Width는 서로 동일 */
  final int cancelFlex; //Expaned 취소버튼 flex 값
  final int completeFlex; //Expaned 완료버튼 flex 값
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 30),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        title: Center(child: Text(title)),
        /* 내용 */
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              /* 왼쪽버튼 */
              Expanded(
                flex: cancelFlex,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: cancelFun,
                  child: Text(
                    cancelText,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              /* 오른쪽버튼 */
              Expanded(
                flex: completeFlex,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: completeFun,
                  child: Text(
                    completeText,
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