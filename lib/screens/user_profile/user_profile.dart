import 'package:mannergamer/utilites/index/index.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  /* Post Detail, Chat Page에서 받은 데이터 */
  final String profileUrl = Get.arguments['profileUrl'];
  final String userName = Get.arguments['userName'];
  final String mannerAge = Get.arguments['mannerAge'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: openBottomSheet, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
              radius: 70,
            ),
            SizedBox(height: 15),
            Text(
              userName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // radius you want
                  side: BorderSide(
                    color: Colors.transparent, //color
                  ),
                ),

                padding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 45), //버튼크기결정
              ),
              child: Text('팔로우',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
            SizedBox(height: 20),
            CustomMannerAge(mannerAge),
            SizedBox(height: 20),
            Divider(thickness: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('받은 매너 평가'),
              onTap: () {},
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
            ),
            Divider(thickness: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('받은 게임 후기'),
              onTap: () {},
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }

  /* 앱바 상단 아이콘 클릭 시 열리는 바텀시트 */
  openBottomSheet() {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 180,
        child: Column(
          children: [
            CustomButtomSheet('신고하기', Colors.blue, () {
              Get.back();
              Get.toNamed('/report');
            }), //신고하기 페이지로 이동
            CustomButtomSheet('팔로우하기', Colors.blue, () {
              Get.back();
            }), //신고하기 페이지로 이동
            CustomButtomSheet('차단하기', Colors.redAccent, () {
              Get.back();
            }), // 사용자 차단 (나중)
            CustomButtomSheet('취소', Colors.blue, () => Get.back()),
            //바텀시트 내리기
          ],
        ),
      ),
    );
  }
}
