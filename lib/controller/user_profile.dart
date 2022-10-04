import 'package:mannergamer/utilites/index.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;

  /* 유저 정보가 존재하는지 여부 확인 */
  Future checkIfDocExists(phone) async {
    try {
      final doc = await _userDB.doc(_auth.currentUser!.uid).get();
      //방금 signup 유저의 id값의 문서가 UserDB에 존재한다면?
      //Home() : createUserName() 으로 이동
      if (doc.exists) {
        //DB에 UID가 있다면? 홈
        Get.offAllNamed('/myapp');
      } else {
        //DB에 UID가 없다면?  닉네임 생성
        Get.offAllNamed('/username', arguments: phone);
      }
    } catch (e) {
      throw e;
    }
  }
}
