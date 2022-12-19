import 'package:mannergamer/utilites/index/index.dart';

class FavoriteModel {
  final String id; //문서의 id == postId
  final String idFrom; //게시글 관심을 표현한 유저 uid
  final String idTo; //게시글을 게시한 유저 uid ( = 관심 표현을 받은 유저 uid )
  final bool isFavorite;
  final Timestamp updatedAt;

  FavoriteModel({
    required this.id,
    required this.idFrom,
    required this.idTo,
    required this.isFavorite,
    required this.updatedAt,
  });

  factory FavoriteModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: snapshot['id'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      isFavorite: snapshot['isFavorite'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
