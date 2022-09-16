import 'package:mannergamer/utilites/index.dart';

class InitialScreenCntroller extends GetxController {
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;

  /* 모든유저정보 */
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    /* firebaseUser가 유저변화 반응형으로 감지하도록 함 */
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    /* firebaseUser변화 감지해서 _setInitialScreen함수 실행 */
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

/* 유저에 따라 다르게 첫화면 띄우기 */
  _setInitialScreen(User? user) {
    if (user == null) {
      /* 유저정보 X , 첫화면 : 사용자등록페이지  */
      Get.offAllNamed('/login');
    } else {
      /* 유저정보 O , 첫화면 : HomePage()  */
      Get.offAllNamed('/');
    }
  }
}
