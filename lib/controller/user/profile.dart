import 'package:mannergamer/utilites/index/index.dart';

// 첫 페이지를 어떻게 결정 할 것인가?
// 1. 유저정보 X : 메인로고Page
// 2. 유저정보 O , DB에 X : 프로필생성 Page
// 3. 둘다 O : Homepage()로 이동.
// 따라서 initialScreen 컨트롤러와 this 컨트롤러와 합칠 것.

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final _auth = FirebaseAuth.instance;
  // 기본 유저프로필 URL
  var defaultProfile = '';

  @override
  void onInit() {
    super.onInit();
    getUserProfileUrl();
  }

  /* 유저 정보가 존재하는지 여부 확인 */
  Future checkIfDocExists(phone) async {
    try {
      final doc = await _userDB.doc(_auth.currentUser!.uid).get();
      // 방금 signup 유저의 id값의 문서가 UserDB에 존재한다면?
      // Home() : createUserName() 으로 이동
      if (doc.exists) {
        // DB에 UID가 있다면? 홈
        Get.offAllNamed('/myapp');
      } else {
        // DB에 UID가 없다면?  닉네임 생성
        Get.offAllNamed('/username', arguments: phone);
      }
    } catch (e) {
      throw e;
    }
  }

  /* 파베 스토리지에서 기본 프로필 URL 가져오기 */
  Future getUserProfileUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'profile/default_profile.png'); // profile 폴더 default_profile.png의 URL주소
      defaultProfile = await ref.getDownloadURL();
      update();
      print(defaultProfile);
    } on FirebaseException catch (e) {
      print('프로필 get 에러 : ${e}');
    }
  }
}
