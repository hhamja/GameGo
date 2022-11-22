import 'package:mannergamer/utilites/index/index.dart';

class FavoriteModel {
  final String id; //문서의 id == postId
  final bool isFavorite;
  final Timestamp updatedAt;

  FavoriteModel({
    required this.id,
    required this.isFavorite,
    required this.updatedAt,
  });

  factory FavoriteModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: snapshot['id'],
      isFavorite: snapshot['isFavorite'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
