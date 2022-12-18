import 'package:mannergamer/utilites/index/index.dart';

class ReviewModel {
  final String idFrom; //리뷰 보낸 uid
  final String idTo; //리뷰 받은 uid
  final String profileUrl; //리뷰 보낸 사람의 프로필
  final String userName; //리뷰 보낸 사람의 이름
  final String feeling; //좋다고 선택 시 'good', 싫다고 선택 시 'bad'
  final String content; //직접 작성한 후기
  final String? reviewType; //리뷰보낸 타입, 나중에 선택지를 제공하여 선택할 것이므로
  final Timestamp createdAt; //후기 보낸 시간

  ReviewModel({
    required this.idFrom,
    required this.idTo,
    required this.profileUrl,
    required this.userName,
    required this.feeling,
    required this.content,
    this.reviewType,
    required this.createdAt,
  });

  factory ReviewModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      profileUrl: snapshot['profileUrl'],
      userName: snapshot['userName'],
      feeling: snapshot['feeling'],
      content: snapshot['content'],
      reviewType: snapshot['reviewType'],
      createdAt: snapshot['createdAt'],
    );
  }
}
