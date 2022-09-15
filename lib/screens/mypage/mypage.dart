import 'package:mannergamer/utilites/index.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 정보'),
        actions: [
          IconButton(
              onPressed: () => {Get.to(() => SettingPage())},
              icon: Icon(Icons.settings_outlined))
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: EdgeInsetsDirectional.only(bottom: 10),
            title: Text('프로필'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                ),
                title: Text('유저이름'),
                description: Text('#유저id'),
                trailing: Icon(Icons.keyboard_control_outlined),
                onPressed: (value) {
                  Get.to(() => ProfileEditPage());
                },
              ),
              SettingsTile(
                title: Stack(
                  fit: StackFit.loose,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      heightFactor: 0.8,
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '매너나이',
                              style: TextStyle(fontSize: 13, height: 1.28),
                            ),
                            IconButton(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.info_outline_rounded,
                                  size: 18,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('첫 나이 20.0세',
                                        style: TextStyle(fontSize: 12)),
                                    Icon(
                                      Icons.arrow_drop_down_sharp,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${currentAgeValue}세',
                                        style: TextStyle(
                                            fontSize: 20,
                                            height: 1.2,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.sentiment_satisfied,
                                        size: 28,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          MannerAgePage(),
                        ],
                      ),
                    ),
                  ],
                ),
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
                title: Text('나의 글 0개'), //나의 글 $state
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
                onPressed: (_) {
                  Get.to(() => MyPostListPage());
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
                title: Text('받은 듀오 후기'),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
                onPressed: (_) {
                  Get.to(() => ReceivedReviewPage());
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('기타'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('공지사항'),
                onPressed: (_) {
                  Get.to(() => AppNoticeListPage());
                },
              ),
              SettingsTile.navigation(
                title: Text('1:1 문의 및 피드백'),
                onPressed: (_) {
                  Get.to(() => FeedbackPage());
                },
              ),
              SettingsTile.navigation(
                title: Text('FAQ'),
                onPressed: (_) {
                  Get.to(() => FAQPage());
                },
              ),
              SettingsTile.navigation(
                title: Text('설정'),
                onPressed: (_) => {Get.to(() => SettingPage())},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
