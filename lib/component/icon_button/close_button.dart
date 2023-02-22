import 'package:flutter/cupertino.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 20),
      icon: Icon(
        CupertinoIcons.clear,
        color: Colors.grey,
        size: 25,
      ),
      onPressed: () => Get.back(),
    );
  }
}
