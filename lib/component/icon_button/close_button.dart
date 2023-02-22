import 'package:flutter/cupertino.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
      icon: Icon(
        CupertinoIcons.clear,
        color: appBlackColor,
        size: 22,
      ),
      onPressed: () => Get.back(),
    );
  }
}
