import 'package:gamegoapp/utilites/index/index.dart';

class MannerLevelModel {
  // 매너레벨, 초기레벨 Lv.30
  final String mannerLevel;
  // 레벨 경험치
  final String levelExp;

  MannerLevelModel({
    required this.mannerLevel,
    required this.levelExp,
  });

  // 서버의 천단위 mannerLevel을 십의자리에서 분리
  // 백의 자리 이상은 매너Lv로 넣고, 십의 자리 이하는 레벨 경험치에 넣기
  factory MannerLevelModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    int mannerLevel = snapshot['mannerLevel'];
    // 레벨부분만 추출
    int level = mannerLevel ~/ 100;
    // 경험치에 해당하는 int만 추출
    int exp = mannerLevel % 100; //

    return MannerLevelModel(
      mannerLevel: level.toString(),
      levelExp: exp.toString(),
    );
  }
}
