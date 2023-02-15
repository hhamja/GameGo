import 'package:mannergamer/utilites/index/index.dart';

class MannerLevelController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  // 매너레벨
  Rx<MannerLevelModel> mannerLevel = MannerLevelModel(
    mannerLevel: '',
    levelExp: '',
  ).obs;
  String get level => mannerLevel.value.mannerLevel;
  String get exp => mannerLevel.value.levelExp;

  // 매너Lv. 데이터 받기
  Future getUserMannerLevel(uid) async {
    // uid를 넣어 해당 유저의 매너Lv. 서버에서 받기
    await _userDB.doc(uid).get().then(
          (e) => mannerLevel.value = MannerLevelModel.fromDocumentSnapshot(e),
        );
  }

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
