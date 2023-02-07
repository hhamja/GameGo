import 'package:mannergamer/utilites/index/index.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Post Detail, Chat Page에서 받은 데이터
  final String profileUrl = Get.arguments['profileUrl'];
  final String userName = Get.arguments['userName'];
  final String mannerAge = Get.arguments['mannerAge'];
  // 해당 유저가 탈퇴유저인 경우 : null
  final String uid = Get.arguments['uid'];

  @override
  Widget build(BuildContext context) {
    print('해당 유저 uid : $uid');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          // IconButton(onPressed: openBottomSheet, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
              radius: 80,
            ),
            SizedBox(height: 15),
            Text(
              userName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            CustomMannerAge(mannerAge),
            SizedBox(height: 20),
            Divider(thickness: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('받은 매너 평가'),
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
            Divider(thickness: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('받은 게임 후기'),
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
            Divider(thickness: 1),
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
