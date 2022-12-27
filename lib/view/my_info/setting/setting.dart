import 'package:mannergamer/utilites/index/index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NtfSettingController _c = Get.put(NtfSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
      ),
      body: Obx(
        () => SettingsList(
          lightTheme: SettingsThemeData(
            settingsListBackground: Colors.white,
          ),
          sections: [
            SettingsSection(
              title: Text('알림 설정'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) {
                    _c.isChatNtf.value = value;
                  },
                  initialValue: _c.isChatNtf.value,
                  title: Text('채팅 알림'),
                  description: Text('메시지 알림'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    _c.isActivitNtf.value = value;
                  },
                  initialValue: _c.isActivitNtf.value,
                  title: Text('활동 알림'),
                  description: Text('관심, 약속설정, 매너평가 등 알림'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    _c.isNoticeNtf.value = value;
                  },
                  initialValue: _c.isActivitNtf.value,
                  title: Text('공지 알림'),
                  description: Text('매너게이머 소식 알림'),
                ),
              ],
            ),
            // SettingsSection(
            //   title: Text('사용자 설정'),
            //   tiles: <SettingsTile>[
            //     SettingsTile.navigation(
            //       title: Text('계정/정보 관리'),
            //       onPressed: (_) {
            //         Get.to(() => AccountManagementPage());
            //       },
            //     ),
            //     SettingsTile.navigation(
            //       title: Text('팔로우 유저 관리'),
            //       onPressed: (_) {
            //         Get.to(() => FavoriteUserManagementPage());
            //       },
            //     ),
            //     SettingsTile.navigation(
            //       title: Text('차단 유저 관리'),
            //       onPressed: (_) {
            //         Get.to(() => BlockUserManagement());
            //       },
            //     ),
            //     SettingsTile.navigation(
            //       title: Text('게시글 미노출 유저 관리'),
            //       onPressed: (_) {
            //         Get.to(() => UnexposeUserManagementPage());
            //       },
            //     ),
            //   ],
            // ),
            SettingsSection(
              title: Text('기타'),
              tiles: <SettingsTile>[
                // SettingsTile.navigation(
                //   title: Text('버전 정보'),
                //   description: Text('최신버전 1.0.0'),
                //   trailing: Text('1.0.0'), //사용자의 현재정보 표시
                //   onPressed: (_) {
                //     return Get.dialog(
                //       AlertDialog(
                //         title: Text(
                //           '최신버전입니다',
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    _c.isMarketingConsent.value = value;
                  },
                  initialValue: _c.isMarketingConsent.value,
                  title: Text('마케팅 정보 수신 동의'),
                ),
                SettingsTile.navigation(
                  title: Text('서비스 이용 약관'),
                  onPressed: (_) {
                    Get.dialog(LogOutDialog());
                  },
                ),
                SettingsTile.navigation(
                  title: Text('개인정보 취급 처리 방침'),
                  onPressed: (_) {
                    Get.dialog(LogOutDialog());
                  },
                ),
                SettingsTile.navigation(
                  title: Text('로그아웃'),
                  onPressed: (_) {
                    Get.dialog(LogOutDialog());
                  },
                ),
                SettingsTile.navigation(
                  title: Text('탈퇴하기'),
                  onPressed: (_) {
                    Get.toNamed('/signout');
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
