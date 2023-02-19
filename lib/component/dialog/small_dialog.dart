import 'package:gamego/utilites/index/index.dart';

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
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
        actionsPadding:
            EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),

        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 왼쪽버튼
              CustomOutlineTextButton(
                40.w,
                5.5.h,
                cancelText,
                cancelFun,
                appBlackColor,
              ),

              SizedBox(
                width: 5.sp,
              ), // 오른쪽버튼
              CustomFilledTextButton(
                40.w,
                5.5.h,
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
