import 'package:mannergamer/utilites/index/index.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        thickness: 1,
        height: 0,
        color: Colors.grey[200],
      ),
    );  }
}