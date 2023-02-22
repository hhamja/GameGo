import 'package:gamegoapp/utilites/index/index.dart';

class NotificationCircleIcon extends StatelessWidget {
  NotificationCircleIcon(
    this.backgroundColor,
    this.icon,
  );

  final Color? backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 13,
      backgroundColor: backgroundColor,
      child: Center(
        child: Icon(
          icon,
          size: 13,
          color: appWhiteColor,
        ),
      ),
    );
  }
}
