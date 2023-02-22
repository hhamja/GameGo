import 'package:gamegoapp/utilites/index/index.dart';

class CustomButtomSheet extends StatelessWidget {
  final String inputText;
  final Color inputColor;
  final Function() onPressed;

  const CustomButtomSheet(this.inputText, this.inputColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.sp,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          inputText,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            fontWeight: FontWeight.normal,
            letterSpacing:
                Theme.of(context).textTheme.bodyMedium!.letterSpacing,
            color: inputColor,
          ),
        ),
      ),
    );
  }
}
