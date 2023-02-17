import 'package:mannergamer/utilites/index/index.dart';

class ReportController extends GetxController {
  final CollectionReference _reportDB =
      FirebaseFirestore.instance.collection('report');

  // 유저가 신고한 내용 파이어스토어에 저장하기
  // 1. 게시물에 대해 신고한 경우 -> chatRoomId = null로 넣기
  // 2. 유저에 대해 신고한 경우 -> postId = null로 넣기
  // 3. 비매너 게임 후기를 수기로 작성하여 보내는 경우 -> postId = null로 넣기
  // 이유) 어떤 게시글이나 게임, 채팅으로 인해서 신고하게 되었는지 파악하기 위함
  Future addUserReport(ReportModel model) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    _batch.set(
      _reportDB.doc(),
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'postId': model.postId,
        'chatRoomId': model.chatRoomId,
        'reportContent': model.reportContent,
        'createdAt': model.createdAt,
      },
    );
    _batch.commit();
  }
}
