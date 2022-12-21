import 'package:mannergamer/utilites/index/index.dart';

class CustomTwoLineListTile extends StatelessWidget {
  CustomTwoLineListTile(
    this.profileUrl,
    this.content,
    this.gamemode,
    this.position,
    this.tear,
    this.isTrailing,
    this.time,
    this.onTap,
  );
  final String profileUrl; //프로필 (Leading 위치)
  final String content; //ListTile 내용 (title 위치)
  final String gamemode; //게임모드
  final String? position; //포지션
  final String? tear; //티어
  final bool isTrailing; //trailing을 표시할지 여부의 bool변수
  final String time; // ~전'으로 시간표시 (박스의 오른쪽 위 끝에 위치)
  final Function() onTap; //ListTile 클릭 시

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      isThreeLine: true,
      minVerticalPadding: 15,
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(profileUrl),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 게임모드 · 포지션 · 티어 */
          Text(
            gamemode,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            position != null ? ' · ${position}' : '',
            style: TextStyle(fontSize: 14),
          ),
          Text(
            tear != null ? ' · ${tear}' : '',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      trailing: isTrailing
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 12),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            )
          : null,
    );
  }
}
