import 'package:gamegoapp/utilites/index/index.dart';

class SignOutFeedBackModel {
  final String feedBackContent; //피드백 내용
  final Timestamp createdAt; //생성 시간

  SignOutFeedBackModel({
    required this.feedBackContent,
    required this.createdAt,
  });

  factory SignOutFeedBackModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return SignOutFeedBackModel(
      feedBackContent: snapshot['feedBackContent'],
      createdAt: snapshot['createdAt'],
    );
  }
}
