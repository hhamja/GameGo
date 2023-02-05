import 'package:mannergamer/utilites/index/index.dart';

class CustomButtomSheet extends StatelessWidget {
  final String inputText;
  final Color inputColor;
  final Function() onPressed;

  const CustomButtomSheet(this.inputText, this.inputColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              inputText,
              style: TextStyle(color: inputColor),
            )),
        width: double.infinity,
      ),
    );
  }
}
