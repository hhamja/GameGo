import 'package:mannergamer/utilites/index/index.dart';

//유저가 신고시 정보수집
class UserReportController extends GetxController {
  final CollectionReference _reportDB =
      FirebaseFirestore.instance.collection('report');

  /* 유저가 신고한 내용 파이어스토어에 저장하기
  1. 게시물에 대해 신고한 경우
  2. 유저에 대해 신고한 경우 */
  Future addUserReport(ReportModel model) async {
    _reportDB.add(
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'reportContent': model.reportContent,
        'createdAt': model.createdAt,
      },
    );
  }
}
