import 'package:mannergamer/utilites/index/index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched1 = true;
  bool isSwitched2 = true;
  bool isSwitched3 = true;
  bool isSwitched4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('알림 설정'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    isSwitched1 = value;
                  });
                },
                initialValue: isSwitched1,
                title: Text('채팅 알림'),
                description: Text('메시지 알림'),
              ),
              SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      isSwitched2 = value;
                    });
                  },
                  initialValue: isSwitched2,
                  title: Text('공지 알림'),
                  description: Text('DuoDuo 소식 알림')),
              SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      isSwitched3 = value;
                    });
                  },
                  initialValue: isSwitched3,
                  title: Text('활동 알림'),
                  description: Text('관심, 공감, 매너평가 등 알림')),
              SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      isSwitched4 = value;
                    });
                  },
                  initialValue: isSwitched4,
                  title: Text('마케팅 알림'),
                  description: Text('마케징 정보 수신 동의 1995-01-26')),
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
    );
  }
}
