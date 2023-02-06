import 'package:mannergamer/utilites/index/index.dart';

class CustomFilledTextButton extends StatelessWidget {
  const CustomFilledTextButton(
    this.w,
    this.h,
    this.content,
    this.onPressed,
  );

  final double? w;
  final double? h;
  final String content;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: appPrimaryColor,
        // border: Border.(
        //   color: appPrimaryColor,
        //   width: 0.3.w,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
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
