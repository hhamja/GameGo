import 'package:mannergamer/utilites/index/index.dart';

class MyInfoPage extends StatefulWidget {
  MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final UserController _user = Get.put(UserController());

  var _createdAt;
  @override
  void initState() {
    super.initState();
    // 현재유저 정보 받기
    _user.getUserInfoByUid(CurrentUser.uid);
    // 가입날짜
    _createdAt =
        Jiffy(_user.userInfo['createdAt'].toDate()).format('yy. MM. dd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 정보'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(
                  () => SettingPage(),
                );
              },
              icon: Icon(Icons.settings_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 내정보 새로고침
          await _user.getUserInfoByUid(CurrentUser.uid);
        },
        displacement: 0,
        child: Obx(
          () => SettingsList(
            lightTheme: SettingsThemeData(
              settingsListBackground: Colors.white,
            ),
            sections: [
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 10),
                title: Text('프로필'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(_user.userInfo['profileUrl']),
                    ),
                    title: Text(_user.userInfo['userName']),
                    description: Text('가입일 : $_createdAt'),
                    trailing: Icon(Icons.keyboard_control_outlined),
                    onPressed: (value) {
                      Get.to(() => EditMyProfilePage());
                    },
                  ),
                  SettingsTile(
                    title: CustomMannerAge(
                      _user.userInfo['mannerAge'].toString(),
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('나의 활동'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: Text('나의 글'),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onPressed: (_) {
                      Get.to(() => MyPostListPage());
                    },
                  ),
                  SettingsTile.navigation(
                    title: Text('관심 게시글'),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onPressed: (_) {
                      Get.toNamed('/favorite');
                    },
                  ),
                  SettingsTile.navigation(
                    title: Text('받은 매너 평가'),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onPressed: (_) {
                      Get.to(() => ReceivedMannerEvaluationPage());
                    },
                  ),
                  SettingsTile.navigation(
                    title: Text('받은 게임 후기'),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onPressed: (_) {
                      Get.to(() => ReceivedGameReviewPage());
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text('기타'),
                tiles: <SettingsTile>[
                  // SettingsTile.navigation(
                  //   title: Text('공지사항'),
                  //   onPressed: (_) {
                  //     Get.to(() => AppNoticeListPage());
                  //   },
                  // ),
                  // SettingsTile.navigation(
                  //   title: Text('1:1 문의 및 피드백'),
                  //   onPressed: (_) {
                  //     Get.to(() => FeedbackPage());
                  //   },
                  // ),
                  // SettingsTile.navigation(
                  //   title: Text('FAQ'),
                  //   onPressed: (_) {
                  //     Get.to(() => FAQPage());
                  //   },
                  // ),
                  SettingsTile.navigation(
                    title: Text('설정'),
                    onPressed: (_) => {Get.to(() => SettingPage())},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
