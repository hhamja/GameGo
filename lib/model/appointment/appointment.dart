import 'package:gamego/utilites/index/index.dart';

class AppointmentModel {
  final String idFrom; //약속을 설정한 사람
  final String idTo; //약속 설정을 당한(?) 사람
  final Timestamp timestamp; //약속날짜와 시간
  final Timestamp createdAt; //약속을 설정하여 버튼을 클릭한 시간 (약속 설정 시간)

  AppointmentModel({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.createdAt,
  });

  factory AppointmentModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      timestamp: snapshot['timestamp'],
      createdAt: snapshot['createdAt'],
    );
  }
}
