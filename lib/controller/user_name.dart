import 'package:mannergamer/utilites/index.dart';

//방금 signup 유저의 id값의 문서가 UserDB에 존재한다면?
//Home() : createUserName() 으로 이동
class UserNameController extends GetxController {
  static UserNameController get to => Get.find<UserNameController>();
  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;

  /* 유저 정보가 존재하는지 여부 확인 */
  Future checkIfDocExists() async {
    try {
      final doc = await _userDB.doc(_auth.currentUser!.uid).get();
      if (doc.exists) {
        //DB에 UID가 있다면? 홈
        Get.offAllNamed('/myapp');
      } else {
        //DB에 UID가 없다면?  닉네임 생성
        Get.offAllNamed('/username');
      }
    } catch (e) {
      throw e;
    }
  }
}
