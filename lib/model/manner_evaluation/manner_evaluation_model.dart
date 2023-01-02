import 'package:mannergamer/utilites/index/index.dart';

class MannerEvaluationModel {
  final String idFrom; //매너 평가 보낸 uid
  final String idTo; //매너 평가 받은 uid
  final List selectList; //선택한 평가 항목의 index 리스트 ex. [1, 3, 7 ,9]
  final Timestamp createdAt; //생성시간

  MannerEvaluationModel({
    required this.idFrom,
    required this.idTo,
    required this.selectList,
    required this.createdAt,
  });

  factory MannerEvaluationModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return MannerEvaluationModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      selectList: snapshot['selectList'],
      createdAt: snapshot['createdAt'],
    );
  }
}
