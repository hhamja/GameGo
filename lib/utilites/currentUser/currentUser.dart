import 'package:mannergamer/utilites/index/index.dart';

class CurrentUser {
  static final String uid = FirebaseAuth.instance.currentUser!.uid;
  static final String name =
      FirebaseAuth.instance.currentUser!.displayName ?? '(이름없음)';
  static final String profile = FirebaseAuth.instance.currentUser!.photoURL!;
  static final String phoneNumber =
      FirebaseAuth.instance.currentUser!.phoneNumber!;
  static final String trimmedPhone = '0' + phoneNumber.substring(3, 13);
}
