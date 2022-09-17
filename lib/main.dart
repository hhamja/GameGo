import 'package:mannergamer/utilites/index.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /* GetX Controller */
  Get.put<UserAuthController>(UserAuthController());
  // Get.put<InitialScreenCntroller>(InitialScreenCntroller());
  // Get.put<CreatePostDropDownBTController>(CreatePostDropDownBTController());
  // Get.put<EditDropDownController>(EditDropDownController());
  // Get.put<HomePageDropDownBTController>(HomePageDropDownBTController());
  // Get.put<FilterPostController>(FilterPostController());
  // Get.put<PostController>(PostController());

  runApp(MyApp());
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: AppRoutes.routes,
      title: 'MannerGamer',
      theme: ThemeData(primarySwatch: Colors.blue), //
      home: Scaffold(
        body: _bodylist[tabIndex], //하단 탭바를 이용한 홈-게시글올리기-채팅-나의정보 페이지
        bottomNavigationBar: BottomNavigationBar(
          onTap: _changeTabindex,
          currentIndex: tabIndex,
          items: [
            _BottomBarItem(Icon(Icons.home_outlined), Icon(Icons.home), '홈'),
            _chatBottomBarItem(),
            _BottomBarItem(
                Icon(Icons.face_outlined), Icon(Icons.face), '나의 정보'),
          ],
        ),
      ),
    );
  }
}
