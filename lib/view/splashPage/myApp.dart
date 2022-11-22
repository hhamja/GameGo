import 'package:mannergamer/utilites/index/index.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* 채팅 컨트롤러 인스턴스 생성
  * 채팅리스트의 안읽은 메시지가 하나라도 있다면 채팅아이콘위에 표시하기 위해 */
  final ChatController _chat = Get.put(ChatController());
  /* 현재유저 uid */
  final String _currentUid = FirebaseAuth.instance.currentUser!.uid;
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
    print('x');
  }

  @override
  Widget build(BuildContext context) {
    _chat.unReadList.value = _chat.chatRoomList
        .where((e) => e.unReadCount['$_currentUid'] != 0)
        .toList();

    return Scaffold(
      body: _bodylist[tabIndex], //하단 탭바를 이용한 홈-게시글올리기-채팅-나의정보 페이지
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => tabIndex = value),
        currentIndex: tabIndex,
        items: [
          _BottomBarItem(Icon(Icons.home_outlined), Icon(Icons.home), '홈'),
          _chat.unReadList.isEmpty || _chat.unReadList.length == 0
              ? _BottomBarItem(
                  Icon(Icons.question_answer_outlined),
                  Icon(Icons.question_answer),
                  '채팅',
                )
              : _BottomBarItem(
                  Badge(
                    child: Icon(Icons.question_answer_outlined),
                    position: BadgePosition.topEnd(end: -10, top: 0),
                    padding: EdgeInsets.all(3),
                  ),
                  Badge(
                    position: BadgePosition.topEnd(end: -10, top: 0),
                    child: Icon(
                      Icons.question_answer,
                    ),
                    padding: EdgeInsets.all(3),
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
          _BottomBarItem(Icon(Icons.face_outlined), Icon(Icons.face), '나의 정보'),
        ],
      ),
    );
  }
}
