import 'package:mannergamer/utilites/index/index.dart';

class CustomPostListTile extends StatelessWidget {
  CustomPostListTile(
    this.profileUrl,
    this.userName,
    this.content,
    this.gamemode,
    this.position,
    this.tear,
    this.time,
    this.onTap,
  );
  final String profileUrl; //프로필 (Leading 위치)
  final String userName; //유저이름 (title 위치)
  final String content; //ListTile 내용 (title 위치)
  final String gamemode; //게임모드
  final String? position; //포지션
  final String? tear; //티어
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 게임모드 · 포지션 · 티어 */
          Text(
            gamemode,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            position != null ? ' · ${position}' : '',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            tear != null ? ' · ${tear}' : '',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
      trailing: Column(
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
      ),
    );
  }
}
