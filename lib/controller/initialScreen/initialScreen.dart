import 'package:mannergamer/utilites/index/index.dart';

class InitialScreenCntroller extends GetxController {
  static InitialScreenCntroller get to => Get.find<InitialScreenCntroller>();
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  /* 모든유저정보 */
  late Rx<User?> firebaseUser;

  /* spalsh 화면을 몇 초동안 보여주고 유저가입상태에서 따라 페이지 이동구현 */
  @override
  void onReady() {
    super.onReady();
    Timer(Duration(milliseconds: 1500), () {
      /* 파이베이스 auth User목록 */
      firebaseUser = Rx<User?>(_auth.currentUser);
      /* AUTH의 유저변화 반응형으로 감지 */
      firebaseUser.bindStream(_auth.userChanges());
      /* firebaseUser변화 감지해서 _setInitialScreen함수 실행 */
      ever(firebaseUser, _setInitialScreen);
    });
  }

  /* 유저가입 상태에 따라 다르게 첫화면 띄우기 
  * 신규회원? 메인로고 페이지
  * Auth에만 유저정보 있고 DB에 유저정보 없는 유저? 프로필 생성 페이지
  * 둘다 있는 유저? MyApp()으로 이동 */
  _setInitialScreen(User? user) async {
    final doc = await _userDB.doc(_auth.currentUser?.uid).get();
    if (user == null) {
      print('신규유저');
      return Get.offAll(MainLogoPage());
    } else if (!doc.exists) {
      print('Auth에만 있고 DB에는 없는 유저');
      return Get.offAll(CreateProfilePage());
    } else {
      print('Auth에도 있고 DB에도 등록되어 있는 유저 : $user');
      return Get.offAll(MyApp());
    }
  }
}
