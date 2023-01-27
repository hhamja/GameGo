import 'package:mannergamer/utilites/index/index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NtfSettingController _c = Get.put(NtfSettingController());
  var isGrantedNtf;
  @override
  void initState() {
    super.initState();
    getNtfPermission();
    _c.getUserPushNtf();
  }

  getNtfPermission() async {
    isGrantedNtf = await Permission.notification.status.isGranted;
  }

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
                  onToggle: (value) async {
                    _c.isChatNtf.value = await value;
                    _c.updateChatPushNtf(_c.isChatNtf.value);
                  },
                  initialValue: isGrantedNtf ? _c.isChatNtf.value : false,
                  title: Text('채팅 알림'),
                  description: Text('메시지 알림을 받습니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    _c.isActivitNtf.value = !_c.isActivitNtf.value;
                    _c.isActivitNtf.value = value;
                    _c.updateActivityPushNtf(_c.isActivitNtf.value);
                  },
                  initialValue: isGrantedNtf ? _c.isActivitNtf.value : false,
                  title: Text('활동 알림'),
                  description: Text('관심, 약속, 매너평가 알림을 받습니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    _c.isMarketingConsent.value = await value;
                    _c.updateMarketingConsent(_c.isMarketingConsent.value);
                  },
                  initialValue:
                      isGrantedNtf ? _c.isMarketingConsent.value : false,
                  title: Text('이벤트 및 소식 알림'),
                  description: Text('이벤트 및 앱 소석 알림을 받습니다.'),
                ),
                // SettingsTile.switchTile(
                //   onToggle: (value) async {
                //     _c.isNightNtf.value = await value;
                //     _c.updateNightPushNtf(_c.isNightNtf.value);
                //   },
                //   initialValue: isGrantedNtf ? _c.isNightNtf.value : false,
                //   title: Text('야간 해택 알림'),
                //   description: Text('21시~08시 사이 해택 알림 푸시를 받습니다.'),
                // ),
              ],
            ),
            SettingsSection(
              title: Text('기타'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text('서비스 이용 약관'),
                  onPressed: (_) {},
                ),
                SettingsTile.navigation(
                  title: Text('개인정보 취급 처리 방침'),
                  onPressed: (_) {},
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
