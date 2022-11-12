class FavoriteListModel {
  final String postId; //게시글 고유 id값
  final String profileUrl; //유저 프로필
  final String userName; //유저의 닉네임
  final String title; //게시글 제목
  final String gamemode; //게임모드
  final String? position; //포지션, 솔로·자유·일반게임만 값을 가짐
  final String? tear; //티어, 솔로·자유만 값을 가짐
  bool isFavorite; //하트버튼에 대한 bool값 -> 토글버튼

  FavoriteListModel({
    required this.postId,
    required this.profileUrl,
    required this.userName,
    required this.title,
    required this.gamemode,
    this.position,
    this.tear,
    required this.isFavorite,
  });

  factory FavoriteListModel.fromDocumentSnapshot(doc, a) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return FavoriteListModel(
      postId: snapshot['postId'],
      userName: snapshot['userName'],
      profileUrl: snapshot['profileUrl'],
      title: snapshot['title'],
      gamemode: snapshot['gamemode'],
      position: snapshot['position'],
      tear: snapshot['tear'],
      isFavorite: a,
      //관심 게시글 목록에 있는 게시글은 관심을 선택한 상태이므로 초기값은 true
    );
  }
}
