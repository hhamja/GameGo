import 'package:mannergamer/utilites/index/index.dart';

class CurrentUser {
  static final String uid = FirebaseAuth.instance.currentUser!.uid;
  static String name =
      FirebaseAuth.instance.currentUser!.displayName ?? '(이름없음)';
  static String profile = FirebaseAuth.instance.currentUser!.photoURL!;
  static String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
  static String trimmedPhone = '0' + phoneNumber.substring(3, 13);
}
