import 'package:gamegoapp/utilites/index/index.dart';

class CustomFullFilledTextButton extends StatelessWidget {
  CustomFullFilledTextButton(
    this.content,
    this.onPressed,
    this.backgroundColor,
  );

  final String content; //ListTile 내용 (title 위치)
  final Function() onPressed; //ListTile 클릭 시
  final backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 58.0,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
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
