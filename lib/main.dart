import 'package:mannergamer/utilites/index.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
