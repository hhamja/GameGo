import 'package:mannergamer/utilites/index/index.dart';

class MannerLevelController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // 매너Lv의 경험치 증가
  Future plusMannerLevel(uid) async {
    // 경험치 10% 증가
    await _userDB.doc(uid).update(
      {'mannerLevel': FieldValue.increment(10)},
    );
  }

  // 매너Lv의 경험치 감소
  Future minusMannerLevel(uid) async {
    // 경험치 10% 감소
    await _userDB.doc(uid).update(
      {
        'mannerLevel': FieldValue.increment(-10),
      },
    );
  }
}
