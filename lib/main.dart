import 'package:gamegoapp/utilites/index/index.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Jiffy.locale('ko');

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        title: appName,
        initialBinding: BindingsBuilder(
          () {
            // 유저 가입 상태에서 따라 첫페이지 다르게 하기
            Get.put(InitialScreenCntroller());
          },
        ),
        // 푸시알림 클릭 시 특정페이지 이동을 위한 네베게이션 Key
        navigatorKey: NavigationService.navigatorKey,
        theme: AppThemeData.appTheme,
        home: SplashPage(),
      ),
    ),
  );
}
