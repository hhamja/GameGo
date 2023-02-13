import 'package:mannergamer/utilites/index/index.dart';

class MyInfoPage extends StatefulWidget {
  MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final UserController _user = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _createdAt;
  @override
  void initState() {
    super.initState();
    _user.getUserInfoByUid(_auth.currentUser!.uid);
    _createdAt =
        Jiffy(_user.userInfo.value.createdAt.toDate()).format('yy. MM. dd');
  }

  @override
  Widget build(BuildContext context) {
    _user.getUserInfoByUid(_auth.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '나의 정보',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => SettingPage(),
              );
            },
            icon: Icon(Icons.settings_outlined),
            iconSize: 18.sp,
          ),
        ],
      ),
      body: Obx(
        () => SettingsList(
          lightTheme: SettingsThemeData(
            settingsListBackground: appWhiteColor,
          ),
          sections: [
            SettingsSection(
              title: Text(
                '프로필',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: CircleAvatar(
                    radius: 25.sp,
                    backgroundImage: NetworkImage(
                      _user.userInfo.value.profileUrl,
                    ),
                  ),
                  title: Text(
                    _user.userInfo.value.userName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  description: Text(
                    '가입일 : $_createdAt',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Icon(Icons.keyboard_control_outlined),
                  onPressed: (value) {
                    Get.to(() => EditMyProfilePage());
                  },
                ),
                SettingsTile(
                  title: CustomMannerAge(
                    _user.userInfo.value.mannerAge.toString(),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: Text(
                '나의 활동',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text(
                    '나의 글',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                  ),
                  onPressed: (_) {
                    Get.to(
                      () => MyPostListPage(),
                    );
                  },
                ),
                SettingsTile.navigation(
                  title: Text(
                    '관심 게시글',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                  ),
                  onPressed: (_) {
                    Get.toNamed('/favorite');
                  },
                ),
                SettingsTile.navigation(
                  title: Text(
                    '받은 매너 평가',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  onPressed: (_) {
                    Get.to(
                      () => ReceivedMannerEvaluationPage(),
                    );
                  },
                ),
                SettingsTile.navigation(
                  title: Text(
                    '받은 게임 후기',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  onPressed: (_) {
                    Get.to(
                      () => ReceivedGameReviewPage(),
                    );
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text(
                '기타',
                style: Theme.of(context).textTheme.labelLarge,
              ),
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
                  title: Text(
                    '설정',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: (_) => {
                    Get.to(
                      () => SettingPage(),
                    ),
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
