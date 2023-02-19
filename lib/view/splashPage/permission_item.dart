import 'package:gamego/utilites/index/index.dart';

class PermissionItem extends StatelessWidget {
  final Icon icon;
  final String permissionName;
  final String guideContent;

  PermissionItem({
    required this.icon,
    required this.permissionName,
    required this.guideContent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: icon,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(permissionName),
            Text(guideContent),
          ],
        ),
      ],
    );
  }
}
