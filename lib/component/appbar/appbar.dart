import 'package:mannergamer/utilites/index/index.dart';

class CustomAppbar extends StatefulWidget {
  final leading;
  final actions;
  final title;
  final centerTitle;

  CustomAppbar({
    required this.leading,
    required this.actions,
    required this.title,
    required this.centerTitle,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      actions: widget.actions,
      title: widget.title,
      centerTitle: widget.centerTitle,
    );
  }
}
