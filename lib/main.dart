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
      initialBinding: BindingsBuilder(
        () => Get.put(
          InitialScreenCntroller(),
        ), //유저 가입 상태에서 따라 첫페이지 다르게 하기
      ),
      theme: ThemeData(primarySwatch: Colors.blue), //
      home: MyApp(),
    ),
  );
}
