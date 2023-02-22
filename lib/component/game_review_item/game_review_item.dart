import 'package:gamegoapp/utilites/index/index.dart';

class GameReviewItem extends StatelessWidget {
  GameReviewItem(
    this.profileUrl,
    this.title,
    this.gamemode,
    this.position,
    this.tear,
    this.time,
  );

  final String profileUrl;
  final String title;
  final String gamemode;
  final String? position;
  final String? tear;
  final String time;

  @override
  Widget build(BuildContext context) {
    // 제목 텍스트 스타일
    final TextStyle _titleTextStyle = TextStyle(
      fontSize: 16,
      letterSpacing: Theme.of(context).textTheme.labelLarge!.letterSpacing,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.bodyMedium!.color,
      overflow: TextOverflow.ellipsis,
    );
    // 서브 텍스트 스타일
    final TextStyle _subTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      letterSpacing: Theme.of(context).textTheme.bodyMedium!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
      color: appBlackColor,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpaceData.screenPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.sp,
            width: 30.sp,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                15.sp,
              ),
              child: Image.network(
                profileUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSpaceData.screenPadding * 0.8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 닉네임
                      Text(
                        title,
                        maxLines: 1,
                        style: _titleTextStyle,
                      ),
                      // 시간
                      Text(
                        '·${time}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // 게임 후기 내용
                  Text(
                    gamemode,
                    style: _subTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
