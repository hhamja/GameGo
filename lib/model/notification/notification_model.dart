import 'package:mannergamer/utilites/index/index.dart';

class NotificationModel {
  final String idTo; //알림 받은 uid
  final String idFrom; //알림 보낸 uid
  /* 알림에 해당하는 게시글 id
  * 약속, 게시글 관심 알림만 필요하므로 nullable */
  final String postId;
  /* 알림 내용 
  * view에서 타입마다 내용 넣을 것이고 오직 공지알림일 때 필요하므로 nullable */
  final String content;
  /* 알림타입 
  * review : 매너후기, appoint : 약속설정, favorite : 게시글 관심, notice : 앱 공지 */
  final String type;
  final Timestamp createdAt; //알림 생성 시간

  NotificationModel({
    required this.idFrom,
    required this.idTo,
    required this.postId,
    required this.content,
    required this.type,
    required this.createdAt,
  });

  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      postId: snapshot['postId'],
      content: snapshot['content'],
      type: snapshot['type'],
      createdAt: snapshot['createdAt'],
    );
  }
}
