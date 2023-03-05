import 'package:gamegoapp/utilites/index/index.dart';

class FcmTokenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // fcm토큰 받아서 유저정보에서 업데이트
  Future getToken() async {
    // 장치의 fcm 토큰 받기
    String? token = await _fcm.getToken();
    debugPrint('fcm 토큰은 $token');
    // 유저정보에서 업데이트
    await _userDB.doc(_auth.currentUser!.uid).update({'pushToken': token});
  }
}
