import 'package:gamegoapp/utilites/index/index.dart';

class CustomOneButtonDialog extends StatelessWidget {
  CustomOneButtonDialog(
    this.content,
    this.buttonText,
    this.onPressed,
  );

  final String content;
  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: appWhiteColor,
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(top: 26),
        insetPadding:
            EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        // 내용
        content: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 26),

        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 확인 버튼
              CustomFilledTextButton(
                80.w,
                45,
                buttonText,
                onPressed,
                appPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
