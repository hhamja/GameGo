import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mannergamer/utilites/index/index.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // fcm 토큰에 대한 컨트롤럴
  final FcmTokenController _token = Get.put(FcmTokenController());

  // 배지 컨트롤러 인스턴스 생성
  // 채팅리스트의 안읽은 메시지가 하나라도 있다면 채팅아이콘위에 표시하기 위해
  final BadgeController _badge = Get.put(BadgeController());
  List _bodylist = [Homepage(), ChatListPage(), MyInfoPage()];
  int tabIndex = 0;

  _BottomBarItem(iconData, activeiconData, labelText) {
    return BottomNavigationBarItem(
      icon: iconData,
      activeIcon: activeiconData,
      label: labelText,
    );
  }

  @override
  void initState() {
    super.initState();
    _token.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 하단 탭바를 이용한 홈-게시글올리기-채팅-나의정보 페이지
      body: _bodylist[tabIndex],
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => setState(() => tabIndex = value),
          currentIndex: tabIndex,
          items: [
            _BottomBarItem(
              Icon(CupertinoIcons.house),
              Icon(CupertinoIcons.house_fill),
              '홈',
            ),
            _badge.unReadList.where((e) => e != 0).length == 0
                ? _BottomBarItem(
                    Icon(CupertinoIcons.chat_bubble_2),
                    Icon(CupertinoIcons.chat_bubble_2_fill),
                    '채팅',
                  )
                : _BottomBarItem(
                    badges.Badge(
                      child: Icon(CupertinoIcons.chat_bubble_2),
                      position: badges.BadgePosition.topEnd(end: -10, top: 0),
                      badgeStyle: badges.BadgeStyle(
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                    badges.Badge(
                      position: badges.BadgePosition.topEnd(end: -10, top: 0),
                      child: Icon(CupertinoIcons.chat_bubble_2_fill),
                      badgeStyle: badges.BadgeStyle(
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                    '채팅',
                  ),
            // BottomNavigationBarItem(
            //     icon: Badge(
            //       child: Icon(Icons.question_answer_outlined),
            //       position: BadgePosition.topEnd(end: -10, top: 0),
            //       padding: EdgeInsets.all(3),
            //     ),
            //     activeIcon: Badge(
            //       position: BadgePosition.topEnd(end: -10, top: 0),
            //       child: Icon(
            //         Icons.question_answer,
            //       ),
            //       padding: EdgeInsets.all(3),
            //     ),
            //     label: '채팅',
            //   ),
            _BottomBarItem(Icon(CupertinoIcons.person),
                Icon(CupertinoIcons.person_fill), 'My'),
          ],
        ),
      ),
    );
  }
}
