import 'package:mannergamer/utilites/index/index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NtfSettingController _c = Get.put(NtfSettingController());

  // @override
  // void initState() {
  //   super.initState();
  //   // 위젯 관찰자 추가
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // /// 세팅 페이지에서 권한 설정 후 변경된 값을 위젯에 반영
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     _c.isGrantedNtf.value = true;
  //     _c.getUserPushNtf();
  //   }
  // }

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
                  onToggle: _c.isGrantedNtf.value
                      // 알림권한 허용된 경우
                      ? (value) async {
                          _c.isChatNtf.value = await value;
                          _c.updateChatPushNtf(_c.isChatNtf.value);
                        }
                      // 알림권한 거절된 경우
                      : (_) => _c.requestNotificationPermission(),
                  initialValue:
                      _c.isGrantedNtf.value ? _c.isChatNtf.value : false,
                  title: Text('채팅 알림'),
                  description: Text('메시지 알림을 받습니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: _c.isGrantedNtf.value
                      // 알림권한 허용된 경우
                      ? (value) async {
                          _c.isActivitNtf.value = value;
                          _c.updateActivityPushNtf(_c.isActivitNtf.value);
                        }
                      // 알림권한 거절된 경우
                      : (_) => _c.requestNotificationPermission(),
                  initialValue:
                      _c.isGrantedNtf.value ? _c.isActivitNtf.value : false,
                  title: Text('활동 알림'),
                  description: Text('관심, 약속, 매너평가 알림을 받습니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: _c.isGrantedNtf.value
                      // 알림권한 허용된 경우
                      ? (value) async {
                          _c.isMarketingConsent.value = await value;
                          _c.updateMarketingConsent(
                              _c.isMarketingConsent.value);
                        }
                      // 알림권한 거절된 경우
                      : (_) => _c.requestNotificationPermission(),
                  initialValue: _c.isGrantedNtf.value
                      ? _c.isMarketingConsent.value
                      : false,
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
