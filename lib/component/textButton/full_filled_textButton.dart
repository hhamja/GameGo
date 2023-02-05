import 'package:mannergamer/utilites/index/index.dart';

class CustomFullTextButton extends StatelessWidget {
  CustomFullTextButton(
    this.content,
    this.onPressed,
  );

  final String content; //ListTile 내용 (title 위치)
  final Function() onPressed; //ListTile 클릭 시

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
        backgroundColor: MaterialStateProperty.all(
          appPrimaryColor,
        ),
      ),
      child: Text(
        content,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
