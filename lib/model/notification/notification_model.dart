import 'package:mannergamer/utilites/index/index.dart';

class NotificationModel {
  final String idTo; //알림 받은 uid
  final String idFrom; //알림 보낸 uid
  final String postId; // 알림에 해당하는 게시글 id
  final String postTitle; // 게시글 제목
  final String userName; // 알림을 보낸 사람의 이름
  final String content; // 알림 내용
  /* 알림타입 
  * review : 매너후기, appoint : 약속설정, favorite : 게시글 관심, night : 앱 공지 */
  final String type;
  final Timestamp createdAt; //알림 생성 시간

  NotificationModel({
    required this.idFrom,
    required this.idTo,
    required this.postId,
    required this.postTitle,
    required this.userName,
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
      postTitle: snapshot['postTitle'],
      userName: snapshot['userName'],
      content: snapshot['content'],
      type: snapshot['type'],
      createdAt: snapshot['createdAt'],
    );
  }
}
