import 'package:mannergamer/utilites/index/index.dart';

class FavoriteModel {
  final String postId; // postId
  final String idFrom; //게시글 관심을 표현한 유저 uid
  final String idTo; //게시글을 게시한 유저 uid ( = 관심 표현을 받은 유저 uid )
  final Timestamp createdAt;

  FavoriteModel({
    required this.postId,
    required this.idFrom,
    required this.idTo,
    required this.createdAt,
  });

  factory FavoriteModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      postId: snapshot['postId'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      createdAt: snapshot['createdAt'],
    );
  }
}
