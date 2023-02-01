import 'package:mannergamer/utilites/index/index.dart';

class FcmTokenController extends GetxController {
  // fcm 인스턴스
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // FireStore User Collection Instance
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // fcm토큰 받아서 유저정보에서 업데이트
  Future getToken() async {
    String? token = await _fcm.getToken(); //장치의 fcm 토큰 받기
    print('fcm 토큰은 $token');
    await _userDB
        .doc(CurrentUser.uid)
        .update({'pushToken': token}); //유저정보에서 업데이트
  }
}
