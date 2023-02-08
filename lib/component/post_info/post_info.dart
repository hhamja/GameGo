import 'package:mannergamer/utilites/index/index.dart';

class CustomPostInfo extends StatelessWidget {
  final postId, title, gamemode, position, tear;
  CustomPostInfo(
      this.postId, this.title, this.gamemode, this.position, this.tear);

  @override
  Widget build(BuildContext context) {
    final _bodySmall = Theme.of(context).textTheme.bodySmall!;
    final TextStyle _subTextStyle = TextStyle(
      fontSize: _bodySmall.fontSize,
      letterSpacing: _bodySmall.letterSpacing,
      color: Colors.grey[600],
    );

    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding:
          EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
      onTap: () {
        Get.toNamed('/postdetail', arguments: {'postId': postId});
      },
      // 게시글 제목
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _bodySmall,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 게임모드 · 포지션 · 티어
          Text(
            gamemode,
            style: _subTextStyle,
          ),
          Text(
            position != null ? ' · ${position}' : '',
            style: _subTextStyle,
          ),
          Text(
            tear != null ? ' · ${tear}' : '',
            style: _subTextStyle,
          ),
        ],
      ),
    );
  }
}
