import 'package:mannergamer/utilites/index/index.dart';

class MyInfoPage extends StatefulWidget {
  MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final UserController _user = Get.put(UserController());
  final NtfSettingController _ntf = Get.put(NtfSettingController());

  @override
  void initState() {
    super.initState();
    _user.getUserInfoByUid(CurrentUser.uid); //현재유저 정보 받기
  }

  @override
  Widget build(BuildContext context) {
    final _createdAt =
        Jiffy(_user.userInfo['createdAt'].toDate()).format('yy. MM. dd'); //가입날짜

    return Scaffold(
      appBar: AppBar(
        title: Text('나의 정보'),
        actions: [
          IconButton(
              onPressed: () async {
                await _ntf.getUserPushNtf(); //페이지 이동 전 알림on/off에 대한 데이터 받기
                print(_ntf.userNtfBool['chatPushNtf']);
                Get.to(
                  () => SettingPage(),
                );
              },
              icon: Icon(Icons.settings_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _user.getUserInfoByUid(CurrentUser.uid); //내정보 새로고침
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
                      Get.to(() => ProfileEditPage(), arguments: {
                        'profileUrl': _user.userInfo['profileUrl'],
                        'userName': _user.userInfo['userName'],
                      });
                    },
                  ),
                  SettingsTile(
                    title: CustomMannerAge(_user.userInfo['mannerAge']),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('나의 활동'),
                tiles: <SettingsTile>[
                  // SettingsTile.navigation(
                  //   title: Text('활동 배지 0개'), //배지 개수 $state
                  //   trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  //   onPressed: (_) {},
                  //
                  // ),
                  SettingsTile.navigation(
                    title: Text('나의 글'), //나의 글 $state
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
                  // SettingsTile.navigation(
                  //   title: Text('받은 매너 평가'),
                  //   trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  //   onPressed: (_) {
                  //     Get.to(() => ReceivedMannerEvaluationPage());
                  //   },
                  // ),
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
