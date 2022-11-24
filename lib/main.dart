import 'package:mannergamer/utilites/index/index.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /* 앱이 백그라운드 상태일때 수신되는 메세지를 처리하는 부분 */
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Jiffy.locale('ko'); //시간표시 한국어로 변환

  Get.put(InitialScreenCntroller());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      title: 'MannerGamer',
      theme: ThemeData(primarySwatch: Colors.blue), //
      home: MyApp(),
    ),
  );
}
