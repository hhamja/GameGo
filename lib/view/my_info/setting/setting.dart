import 'package:gamegoapp/utilites/index/index.dart';

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
        automaticallyImplyLeading: false,
        title: Text(
          '설정',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
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
                '알림 설정',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  activeSwitchColor: appPrimaryColor,
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
                  title: Text(
                    '채팅 알림',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  description: Text(
                    '메시지 알림을 받습니다.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SettingsTile.switchTile(
                  activeSwitchColor: appPrimaryColor,
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
                  title: Text(
                    '활동 알림',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  description: Text(
                    '관심, 약속, 매너평가 알림을 받습니다.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SettingsTile.switchTile(
                  activeSwitchColor: appPrimaryColor,
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
                  title: Text(
                    '이벤트 및 소식 알림',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  description: Text(
                    '이벤트 및 앱 소석 알림을 받습니다.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
              title: Text(
                '기타',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text(
                    '서비스 이용 약관',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: (_) {},
                ),
                SettingsTile.navigation(
                  title: Text(
                    '개인정보 취급 처리 방침',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: (_) {},
                ),
                SettingsTile.navigation(
                  title: Text(
                    '로그아웃',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: (_) {
                    Get.dialog(LogOutDialog());
                  },
                ),
                SettingsTile.navigation(
                  title: Text(
                    '탈퇴하기',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
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
