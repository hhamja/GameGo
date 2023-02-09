import 'package:mannergamer/utilites/index/index.dart';

class CustomSmallDialog extends StatelessWidget {
  CustomSmallDialog(
    this.content,
    this.cancelText,
    this.completeText,
    this.cancelFun,
    this.completeFun,
  );

  final String content; //Dialog 내용
  final String cancelText; //왼쪽 버튼 내용, ex)취소
  final String completeText; //오른쪽 버튼 내용, ex)확인
  final Function() cancelFun; //취소버튼의 onPressed()
  final Function() completeFun; //완료버튼의 onPressed()
  // cancelFlex : completeFlex = 1:1이면 버튼 Width는 서로 동일

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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
