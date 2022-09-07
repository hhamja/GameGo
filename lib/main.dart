import 'package:mannergamer/utilites/index.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
      url: 'https://whpjzctadbbslbgnkttx.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndocGp6Y3RhZGJic2xiZ25rdHR4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTc1MzA1MzksImV4cCI6MTk3MzEwNjUzOX0.MTT4HqcGbBM5cdeQl0s0mv-kUJV1lrl_fmsqn1dFkFc');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      // 라우트 관리
      GetPage(name: '/', page: () => MyApp()),
      GetPage(name: '/login', page: () => LogInPage()),
      GetPage(name: '/home', page: () => Homepage()),
      GetPage(name: '/chat', page: () => ChatListPage()),
      GetPage(name: '/ntf', page: () => NotificationPage()),
      GetPage(name: '/postDetail', page: () => UserPostDetailPage()),
      GetPage(name: '/reportList', page: () => ReportPostPage()),
      GetPage(name: '/illegal', page: () => IllegallyPostedPage()),

      GetPage(name: '/otherReason', page: () => OtherReasonsPage()),
      GetPage(
        name: '/search',
        page: () => SerachPage(),
        transition: Transition.noTransition,
      ),
      GetPage(name: '/addPost', page: () => HomeAddPost()),
    ],
    title: 'MannerGamer',
    theme: ThemeData(primarySwatch: Colors.blue), // material design3로 앱 색 설정
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
