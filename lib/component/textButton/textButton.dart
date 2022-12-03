import 'package:mannergamer/utilites/index/index.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton(
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
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.blue,
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
