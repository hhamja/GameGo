import 'package:mannergamer/utilites/index/index.dart';

// 흰색 백그라운드에 outline이 핑크색
class CustomOutlineTextButton extends StatelessWidget {
  const CustomOutlineTextButton(
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
        color: appLightWhite,
        border: Border.all(
          color: appPrimaryColor,
          width: 0.3.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
        ),
      ),
      child: TextButton(
        child: Text(
          content,
          style: TextStyle(
            fontSize: AppTextStyle.fullButtonTextStyle.fontSize,
            letterSpacing: AppTextStyle.fullButtonTextStyle.letterSpacing,
            fontWeight: AppTextStyle.fullButtonTextStyle.fontWeight,
            color: appPrimaryColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
