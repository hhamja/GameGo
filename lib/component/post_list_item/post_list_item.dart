import 'package:gamegoapp/utilites/index/index.dart';

class CustomPostListItem extends StatelessWidget {
  CustomPostListItem(
    this.profileUrl,
    this.userName,
    this.title,
    this.gamemode,
    this.position,
    this.tear,
    this.time,
    this.onTap,
  );
  final String profileUrl;
  final String userName;
  final String title;
  final String gamemode;
  final String? position;
  final String? tear;
  final String time;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    // 닉네임 스타일
    // 제목 텍스트 스타일
    final TextStyle _nameTextStyle = TextStyle(
      fontSize: 16,
      letterSpacing: Theme.of(context).textTheme.labelLarge!.letterSpacing,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.bodyMedium!.color,
      overflow: TextOverflow.ellipsis,
    );
    // 제목 텍스트 스타일
    final TextStyle _titleTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      letterSpacing: Theme.of(context).textTheme.bodyMedium!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
      color: Theme.of(context).textTheme.bodyMedium!.color,
      overflow: TextOverflow.ellipsis,
    );
    // 제목 아래의 서브 텍스트
    final TextStyle _subTextStyle = TextStyle(
      fontSize: 14,
      letterSpacing: Theme.of(context).textTheme.bodySmall!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
      color: appGreyColor,
    );
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpaceData.screenPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  profileUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: AppSpaceData.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 닉네임
                        Text(
                          userName,
                          style: _nameTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    // 제목
                    Text(
                      title,
                      maxLines: 1,
                      style: _titleTextStyle,
                    ),
                    SizedBox(height: 3),
                    // 게임모드 · 포지션 · 티어
                    Row(
                      children: [
                        Text(
                          gamemode,
                          style: _subTextStyle,
                        ),
                        Text(
                          position != null ? '·${position}' : '',
                          style: _subTextStyle,
                        ),
                        Text(
                          tear != null ? '·${tear}' : '',
                          style: _subTextStyle,
                        ),
                        // 글 시간
                        Text(
                          time == '' ? '' : '·${time}',
                          style: _subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
