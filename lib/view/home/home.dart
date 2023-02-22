import 'package:flutter/cupertino.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 게임모드, 포지션, 티어 드랍다운버튼
        title: HomeDropDownButton(),
        actions: [
          // 알림 자명종 버튼
          IconButton(
            onPressed: () => {
              Get.toNamed('/notification'),
            },
            icon: Icon(
              CupertinoIcons.bell,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        child: HomePostList(),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.to(
            () => AddPostPage(),
          );
        },
        child: Icon(
          Icons.add,
          color: appWhiteColor,
        ),
      ),
    );
  }
}
