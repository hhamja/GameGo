import 'package:gamegoapp/utilites/index/index.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 0,
      color: Colors.grey[300],
    );
  }
}
