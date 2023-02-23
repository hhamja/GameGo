import 'package:gamegoapp/utilites/index/index.dart';

class MyInfoPage extends StatelessWidget {
  MyInfoPage({Key? key}) : super(key: key);

  final MyProfileController _c = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    // 가입 날짜
    final String _createdAt =
        Jiffy(_c.userInfo.createdAt.toDate()).format('yy. MM. dd');

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
          ),
        ],
      ),
      body: _c.obx(
        onEmpty: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '내 정보를 불러올 수 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '지속적으로 발생한다면 고객센터로 문의해주세요.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        onError: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '내 정보를 불러올 수 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '지속적으로 발생한다면 고객센터로 문의해주세요.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        (state) => SettingsList(
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
                    radius: 30,
                     backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      _c.userInfo.profileUrl,
                    ),
                  ),
                  title: Text(
                    _c.userInfo.userName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  description: Text(
                    '가입일 : $_createdAt',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Icon(
                    Icons.keyboard_control_outlined,
                  ),
                  onPressed: (value) {
                    Get.to(
                      () => EditMyProfilePage(),
                    );
                  },
                ),
                SettingsTile(
                  title: CustomMannerLevel(
                    // level
                    '${_c.userInfo.mannerLevel ~/ 100}',
                    true,
                    // exp
                    '${_c.userInfo.mannerLevel % 100}',
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
