import 'package:gamegoapp/utilites/index/index.dart';

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
      height: 58.0,
      decoration: BoxDecoration(
        color: appWhiteColor,
        border: Border.all(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
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
