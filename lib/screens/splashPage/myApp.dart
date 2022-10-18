import 'package:mannergamer/utilites/index/index.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tabIndex = 0;
  void _changeTabindex(i) {
    setState(() {
      tabIndex = i;
    });
  }

  List _bodylist = [Homepage(), ChatListPage(), MyPage()];

  _chatBottomBarItem() {
    int chatNumber = 1;
    if (chatNumber == 0) {
      return BottomNavigationBarItem(
        icon: Icon(Icons.question_answer_outlined),
        activeIcon: Icon(Icons.question_answer),
        label: '채팅',
      );
    } else {
      return BottomNavigationBarItem(
        icon: Badge(
          badgeContent: Text('${chatNumber}'),
          child: Icon(Icons.question_answer_outlined),
        ),
        activeIcon: Badge(
          badgeContent: Text('${chatNumber}'),
          child: Icon(Icons.question_answer),
        ),
        label: '채팅',
      );
    }
  }

  _BottomBarItem(iconData, activeiconData, labelText) {
    return BottomNavigationBarItem(
      icon: iconData,
      activeIcon: activeiconData,
      label: labelText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodylist[tabIndex], //하단 탭바를 이용한 홈-게시글올리기-채팅-나의정보 페이지
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeTabindex,
        currentIndex: tabIndex,
        items: [
          _BottomBarItem(Icon(Icons.home_outlined), Icon(Icons.home), '홈'),
          _chatBottomBarItem(),
          _BottomBarItem(Icon(Icons.face_outlined), Icon(Icons.face), '나의 정보'),
        ],
      ),
    );
  }
}
