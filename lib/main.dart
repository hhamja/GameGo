import 'package:mannergamer/utilites/index/index.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Jiffy.locale('ko'); //시간표시 한국어로 변환

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      title: 'MannerGamer',
      initialBinding: BindingsBuilder(() {
        Get.put(InitialScreenCntroller()); //유저 가입 상태에서 따라 첫페이지 다르게 하기
        Get.put(NotificationController()); //푸시알림 초기 설정
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.blue,
          onPrimary: Colors.blue,
        ),
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        brightness: Brightness.light, // 밝기 여부
        scaffoldBackgroundColor: Colors.white, // 앱 배경색
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        ), // 상단바 그림자, 배경색
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ), // 플로팅 버튼 배경색
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontStyle: FontStyle.italic,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: SplashPage(),
    ),
  );
}
