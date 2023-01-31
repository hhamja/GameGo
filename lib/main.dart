import 'package:mannergamer/utilites/index/index.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Jiffy.locale('ko');

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      title: '게임한판(AGame)',
      initialBinding: BindingsBuilder(
        () {
          // 유저 가입 상태에서 따라 첫페이지 다르게 하기
          Get.put(InitialScreenCntroller());
        },
      ),
      // 푸시알림 클릭 시 특정페이지 이동을 위한 네베게이션 Key
      navigatorKey: NavigationService.navigatorKey,
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
      ),
      home: SplashPage(),
    ),
  );
}
