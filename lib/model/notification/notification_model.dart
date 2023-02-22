import 'package:gamegoapp/utilites/index/index.dart';

class NotificationModel {
  final String idTo;
  final String idFrom;
  final String postId; // 알림에 해당하는 게시글 id
  final String chatRoomId; // 푸시알림 클릭 후 특정페이지 이동시 아규먼트 전달위해
  final String postTitle; // 게시글 제목
  final String userName; // 알림을 보낸 사람의 이름
  final String content; // 알림 내용
  // 알림타입
  // review : 매너 게임후기, appoint : 약속설정, favorite : 게시글 관심, notice : 앱 공지
  final String type;
  final Timestamp createdAt;

  NotificationModel({
    required this.idFrom,
    required this.idTo,
    required this.postId,
    required this.chatRoomId,
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
      chatRoomId: snapshot['chatRoomId'],
      postTitle: snapshot['postTitle'],
      userName: snapshot['userName'],
      content: snapshot['content'],
      type: snapshot['type'],
      createdAt: snapshot['createdAt'],
    );
  }
}
