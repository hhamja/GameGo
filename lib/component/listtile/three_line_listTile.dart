import 'package:mannergamer/utilites/index/index.dart';

class CustomThreeLineListTile extends StatelessWidget {
  CustomThreeLineListTile(
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
      color: appDeepDarkGrey,
    );
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpaceData.screenPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 32.sp,
              width: 32.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.sp),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 닉네임
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 3.sp),
                    // 제목
                    Text(
                      title,
                      maxLines: 1,
                      style: _titleTextStyle,
                    ),
                    SizedBox(height: 3.sp),
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
                        ), // 글 시간
                        Text(
                          '·${time}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: appGrayColor,
                          ),
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
