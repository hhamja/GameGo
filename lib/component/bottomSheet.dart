import 'package:mannergamer/utilites/index/index.dart';

class ButtomSheetContent extends StatelessWidget {
  final String inputText;
  final Color inputColor;
  final void Function() clickCcontent;

  const ButtomSheetContent(this.inputText, this.inputColor, this.clickCcontent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: TextButton(
            onPressed: clickCcontent,
            child: Text(
              inputText,
              style: TextStyle(color: inputColor),
            )),
        width: double.infinity,
      ),
    );
  }
}
