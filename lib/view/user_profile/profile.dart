import 'package:gamegoapp/utilites/index/index.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Post Detail, Chat Page에서 받은 데이터
  final String profileUrl = Get.arguments['profileUrl'];
  final String userName = Get.arguments['userName'];
  final String mannerLevel = Get.arguments['mannerLevel'];
  // 해당 유저가 탈퇴유저인 경우 : null
  final String uid = Get.arguments['uid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '프로필',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        child: Column(
          children: [
            SizedBox(height: AppSpaceData.heightMedium),
            CircleAvatar(
               backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(profileUrl),
              radius: 80,
            ),
            SizedBox(height: 13),
            Text(
              userName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: AppSpaceData.heightMedium),
            CustomMannerLevel(mannerLevel, false, ''),
            SizedBox(height: AppSpaceData.heightSmall),
            CustomDivider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              title: Text(
                '받은 매너 평가',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Get.to(
                  () => UserMannerEvaluationPage(),
                  arguments: {
                    'uid': uid,
                  },
                );
              },
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              title: Text(
                '받은 게임 후기',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Get.to(
                  () => UserGameReviewPage(),
                  arguments: {
                    'uid': uid,
                  },
                );
              },
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
            ),
          ],
        ),
      ),
    );
  }
  // // 앱바 상단 아이콘 클릭 시 열리는 바텀시트
  // openBottomSheet() {
  //   return Get.bottomSheet(
  //     Container(
  //       color: appWhiteColor,
  //       height: 120,
  //       child: Column(
  //         children: [
  //           // CustomButtomSheet('팔로우하기', Colors.blue, () {
  //           //   Get.back();
  //           // }),
  //           // CustomButtomSheet(
  //           //   '차단하기',
  //           //   Colors.redAccent,
  //           //   () {
  //           //     Get.back();
  //           //   },
  //           // ), // 사용자 차단 (나중)
  //           CustomButtomSheet(
  //             '취소',
  //             Colors.blue,
  //             () => Get.back(),
  //           ),
  //           //바텀시트 내리기
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
