import 'package:mannergamer/utilites/index/index.dart';

class NotificationCircleIcon extends StatelessWidget {
  NotificationCircleIcon(
    this.backgroundColor,
    this.icon,
  );

  final Color? backgroundColor; //아이콘 배경 색
  final IconData? icon; //아이콘

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Center(
        child: Icon(
          icon,
          color: appWhiteColor,
        ),
      ),
    );
  }
}
