import 'package:mannergamer/utilites/index.dart';

class InitialScreenCntroller extends GetxController {
  static InitialScreenCntroller get to => Get.find<InitialScreenCntroller>();

  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;

  /* 모든유저정보 */
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    /* 파이베이스 auth User목록 */
    firebaseUser = Rx<User?>(_auth.currentUser);
    /* AUTH의 유저변화 반응형으로 감지 */
    firebaseUser.bindStream(_auth.userChanges());
    /* firebaseUser변화 감지해서 _setInitialScreen함수 실행 */
    ever(firebaseUser, _setInitialScreen);
    print('현재유저정보 ${_auth.currentUser}');
  }

  /* 유저에 따라 다르게 첫화면 띄우기 */
  _setInitialScreen(User? user) {
    if (user == null) {
      /* 유저정보 X , 첫화면 : 사용자등록페이지  */
      print('유저null ${user}');
      Get.offAll(() => SignUPPage());
    } else {
      /* 유저정보 O , 첫화면 : HomePage()  */
      print('유저정보 O : ${user}');
      Get.offAll(() => Homepage());
    }
  }
}
