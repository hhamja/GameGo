import 'package:mannergamer/utilites/index/index.dart';

class MannerAgeController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // double _increment = 0.1;
  // double _decrement = -0.1;

  // 매너나이 증가 시키는 함수
  // #### 버그 ####
  // 파이어스토어에 소숫점 단위로 증가, 감소를 직접적으로 하게 되면 정수타입에서 오는 시스템적 오류가 발생
  // 따라서, 값을 받아서 클라이언트단에서 수정 후 서버로 넘겨주는 방식을 택해야할듯.
  Future plusMannerAge(uid) async {
    num _increment = Decimal.parse('0.1').toDouble();
    // 유저 데이터의 매너나이 +0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(_increment),
      },
    );
  }

  // 매너나이 감소 시키는 함수
  // #### 버그 ####
  // 파이어스토어에 소숫점 단위로 증가, 감소를 직접적으로 하게 되면 정수타입에서 오는 시스템적 오류가 발생
  // 따라서, 값을 받아서 클라이언트단에서 수정 후 서버로 넘겨주는 방식을 택해야할듯.
  Future minusMannerAge(uid) async {
    num _decrement = Decimal.parse('-0.1').toDouble();
    // 유저 데이터의 매너나이 -0.1
    await _userDB.doc(uid).update(
      {
        'mannerAge': FieldValue.increment(_decrement),
      },
    );
  }
}
