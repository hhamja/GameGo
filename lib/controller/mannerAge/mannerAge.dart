import 'package:mannergamer/utilites/index/index.dart';

class MannerAgeController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 매너나이 증가 시키는 함수 */
  Future plusMannerAge(uid) async {
    //유저 데이터의 매너나이 +0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(1 / 10),
      },
    );
  }

  /* 매너나이 감소 시키는 함수 */
  Future minusMannerAge(uid) async {
    //유저 데이터의 매너나이 -0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(-1 / 10),
      },
    );
  }
}
