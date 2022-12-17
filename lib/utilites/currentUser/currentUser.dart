import 'package:mannergamer/utilites/index/index.dart';

class CurrentUser {
  static final String uid = FirebaseAuth.instance.currentUser!.uid;
}
