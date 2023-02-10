import 'package:mannergamer/utilites/index/index.dart';

// 흰색 백그라운드에 outline이 핑크색
class CustomFullOutlineTextButton extends StatelessWidget {
  const CustomFullOutlineTextButton(this.content, this.onPressed, this.color);

  final String content;
  final color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 7.h,
      decoration: BoxDecoration(
        color: appWhiteColor,
        border: Border.all(
          color: color,
          width: 0.7.sp,
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
            color: color,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
