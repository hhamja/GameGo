import 'package:mannergamer/utilites/index/index.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
