import 'package:mannergamer/utilites/index/index.dart';

class MannerAgeController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // double _increment = 0.1;
  // double _decrement = -0.1;

  // 매너나이 증가 시키는 함수
  Future plusMannerAge(uid) async {
    final double _increment = Decimal.parse('1/10').toDouble();
    // 유저 데이터의 매너나이 +0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(_increment),
      },
    );
  }

  // 매너나이 감소 시키는 함수
  Future minusMannerAge(uid) async {
    final double _decrement = Decimal.parse('-1/10').toDouble();
    // 유저 데이터의 매너나이 -0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(_decrement),
      },
    );
  }
}
