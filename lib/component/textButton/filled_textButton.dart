import 'package:gamego/utilites/index/index.dart';

class CustomFilledTextButton extends StatelessWidget {
  const CustomFilledTextButton(
    this.w,
    this.h,
    this.content,
    this.onPressed,
    this.backgroundColor,
  );

  final double? w;
  final double? h;
  final String content;
  final Function() onPressed;
  final backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: backgroundColor,
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
