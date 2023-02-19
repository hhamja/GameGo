import 'package:gamego/utilites/index/index.dart';

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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        backgroundColor: appWhiteColor,
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(top: 20.sp),
        insetPadding:
            EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        // 내용
        content: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
        actionsPadding:
            EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),

        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 확인 버튼
              CustomFilledTextButton(
                80.w,
                5.5.h,
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
