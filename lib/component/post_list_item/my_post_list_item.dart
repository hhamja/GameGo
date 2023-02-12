import 'package:mannergamer/utilites/index/index.dart';

class CustomMyPostListItem extends StatelessWidget {
  CustomMyPostListItem(
    this.title,
    this.gamemode,
    this.position,
    this.tear,
    this.time,
    this.onTap,
  );

  final String title;
  final String gamemode;
  final String? position;
  final String? tear;
  final String time;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
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
      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
      letterSpacing: Theme.of(context).textTheme.bodySmall!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
      color: appGreyColor,
    );
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSpaceData.screenPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 제목 또는 닉네임
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '내일 저녁에 같이 게임할 듀오 여성분 구합니다 많은 관심 부탁드려요.',
                          maxLines: 2,
                          style: _titleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.sp),
                  // 게임모드 · 포지션 · 티어
                  Row(
                    children: [
                      Text(
                        gamemode,
                        style: _subTextStyle,
                      ),
                      Text(
                        position != null ? ' ·${position}' : '',
                        style: _subTextStyle,
                      ),
                      Text(
                        tear != null ? '·${tear}' : '',
                        style: _subTextStyle,
                      ),
                      // 글 시간
                      Text(
                        '·${time}',
                        style: _subTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
