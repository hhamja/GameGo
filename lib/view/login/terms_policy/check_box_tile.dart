import 'package:gamego/utilites/index/index.dart';

class CustomCircleCheckBoxTile extends StatefulWidget {
  final bool isChecked;
  final Function() onTap;
  final String content;
  final trailing;

  CustomCircleCheckBoxTile(
    this.isChecked,
    this.onTap,
    this.content,
    this.trailing,
  );

  @override
  State<CustomCircleCheckBoxTile> createState() =>
      _CustomCircleCheckBoxTileState();
}

class _CustomCircleCheckBoxTileState extends State<CustomCircleCheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    final double circleSize = 18.sp;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      onTap: widget.onTap,
      // 원형 체크박스
      leading: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isChecked ? appPrimaryColor : appWhiteColor,
          border: Border.all(color: Colors.grey),
        ),
        child: widget.isChecked
            ? Icon(
                Icons.check,
                size: circleSize * 2 / 3,
                color: appWhiteColor,
              )
            : Container(),
      ),
      // 체크박스 항목의 텍스트
      title: Text(
        widget.content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: widget.trailing,
    );
  }
}
