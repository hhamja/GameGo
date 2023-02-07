import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.clear,
        color: appBlackColor,
        size: 15.sp,
      ),
      onPressed: () => Get.back(),
    );
  }
}
