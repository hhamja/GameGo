import 'package:mannergamer/utilites/index/index.dart';

class CustomPostInfo extends StatelessWidget {
  final postId, title, gamemode, position, tear;
  CustomPostInfo(
      this.postId, this.title, this.gamemode, this.position, this.tear);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      onTap: () {
        Get.toNamed('/postdetail', arguments: {'postId': postId});
      },
      /* 게시글 제목 */
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 게임모드 · 포지션 · 티어 */
          Text(
            gamemode,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            position != null ? ' · ${position}' : '',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            tear != null ? ' · ${tear}' : '',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
