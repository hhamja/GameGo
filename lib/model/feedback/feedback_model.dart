import 'package:mannergamer/utilites/index/index.dart';

class FeedBackModel {
  final String feedBackContent; //피드백 내용
  final Timestamp createdAt; //생성 시간

  FeedBackModel({
    required this.feedBackContent,
    required this.createdAt,
  });

  factory FeedBackModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return FeedBackModel(
      feedBackContent: snapshot['feedBackContent'],
      createdAt: snapshot['createdAt'],
    );
  }
}
