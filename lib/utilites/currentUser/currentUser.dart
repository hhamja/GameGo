import 'package:mannergamer/utilites/index/index.dart';

class CurrentUser {
  static final String uid = FirebaseAuth.instance.currentUser!.uid;
  static final String name =
      FirebaseAuth.instance.currentUser!.displayName ?? '(이름없음)';
  static final String profile = FirebaseAuth.instance.currentUser!.photoURL!;
}
