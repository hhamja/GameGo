import 'package:mannergamer/utilites/index/index.dart';

class ReportModel {
  final String idFrom; //신고를 보낸 uid
  final String idTo; //신고를 받은 uid
  final String reportContent; //신고내용
  final Timestamp createdAt; //신고한 시간

  ReportModel({
    required this.idFrom,
    required this.idTo,
    required this.reportContent,
    required this.createdAt,
  });

  factory ReportModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ReportModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      reportContent: snapshot['reportContent'],
      createdAt: snapshot['createdAt'],
    );
  }
}
