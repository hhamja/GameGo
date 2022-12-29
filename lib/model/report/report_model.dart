import 'package:mannergamer/utilites/index/index.dart';

class ReportModel {
  final String idFrom; //신고보내는 uid
  //(보내는쪽 uid만 알아도 누굴 상대로 신고했는지 알 수 있다.)
  final String? postId; //게시글 id (게시글에서 신고하기 한 경우에만 필요하므로 nullabe)
  final String? chatRoomId; //채팅방 id(채팅방에서 신고한 경우에만 필요하므로 nullabe)
  final String reportContent; //신고내용
  final Timestamp createdAt; //신고한 시간

  ReportModel({
    required this.idFrom,
    this.postId,
    this.chatRoomId,
    required this.reportContent,
    required this.createdAt,
  });

  factory ReportModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ReportModel(
      idFrom: snapshot['idFrom'],
      postId: snapshot['postId'],
      chatRoomId: snapshot['chatRoomId'],
      reportContent: snapshot['reportContent'],
      createdAt: snapshot['createdAt'],
    );
  }
}
