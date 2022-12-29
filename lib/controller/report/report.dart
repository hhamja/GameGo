import 'package:mannergamer/utilites/index/index.dart';

//유저가 신고시 정보수집
class ReportController extends GetxController {
  final CollectionReference _reportDB =
      FirebaseFirestore.instance.collection('report');

  /* 유저가 신고한 내용 파이어스토어에 저장하기
  1. 게시물에 대해 신고한 경우 -> chatRoomId = null로 넣기
  2. 유저에 대해 신고한 경우 -> postId = null로 넣기 */
  Future addUserReport(ReportModel model) async {
    _reportDB.add(
      {
        'idFrom': model.idFrom,
        'postId': model.postId,
        'chatRoomId': model.chatRoomId,
        'reportContent': model.reportContent,
        'createdAt': model.createdAt,
      },
    );
  }
}
