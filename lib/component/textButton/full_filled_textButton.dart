import 'package:mannergamer/utilites/index/index.dart';

class CustomFullFilledTextButton extends StatelessWidget {
  CustomFullFilledTextButton(
    this.content,
    this.onPressed,
  );

  final String content; //ListTile 내용 (title 위치)
  final Function() onPressed; //ListTile 클릭 시

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 7.5.h,
      decoration: BoxDecoration(
        color: appPrimaryColor,
        // border: Border.all(
        //   color: appPrimaryColor,
        //   width: 0.3.w,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.sp),
        ),
      ),
      child: TextButton(
        child: Text(
          content,
          style: AppTextStyle.fullButtonTextStyle,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
