import 'package:gamegoapp/utilites/index/index.dart';

class CustomSmallDialog extends StatelessWidget {
  CustomSmallDialog(
    this.content,
    this.cancelText,
    this.completeText,
    this.cancelFun,
    this.completeFun,
  );

  final String content;
  final String cancelText;
  final String completeText;
  final Function() cancelFun;
  final Function() completeFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: appWhiteColor,
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(top: 30),
        insetPadding:
            EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        // 내용
        content: Container(
          width: 100.w,
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),

        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 왼쪽버튼
              CustomOutlineTextButton(
                35.w,
                45,
                cancelText,
                cancelFun,
                appDeepDarkGrey,
              ),
              SizedBox(width: 10),
              // 오른쪽버튼
              CustomFilledTextButton(
                35.w,
                45,
                completeText,
                completeFun,
                appPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
