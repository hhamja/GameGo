import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index.dart';

//당근마켓 같은 채팅시스템 구현. 외부에서 가져다 쓰고 추후에 사용자가 많아지면 직접 구현.
class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  bool _click = true;
  List<CircleAvatar> _userAvatar = [
    CircleAvatar(child: Icon(Icons.person_rounded)),
    CircleAvatar(child: Icon(Icons.person_rounded)),
    CircleAvatar(child: Icon(Icons.person_rounded)),
    CircleAvatar(child: Icon(Icons.person_rounded)),
  ];
  List<Text> _titlelist = [
    Text('닉네임1'),
    Text('닉네임2'),
  ];
  List<Text> _subtitleList = [
    Text('마지막 채팅 내용1'),
    Text('마지막 채팅 내용2'),
  ];
  List<Text> _trailingList = [
    Text('1일전'),
    Text('2일전'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
        actions: [
          IconButton(
            onPressed: () => {Get.toNamed('/ntf')},
            icon: Icon(Icons
                .notifications_none_outlined), //아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _trailingList.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.4,
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  icon: (_click == true)
                      ? Icons.notifications
                      : Icons.notifications_off,
                  onPressed: (_) {
                    setState(() {
                      _click = !_click;
                    });
                  },
                ),
                SlidableAction(
                  onPressed: (_) {
                    setState(() {
                      _userAvatar.removeAt(index);
                      _titlelist.removeAt(index);
                      _subtitleList.removeAt(index);
                      _trailingList.removeAt(index);
                    });
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: ListTile(
              leading: _userAvatar[index],
              title: _titlelist[index],
              subtitle: _subtitleList[index],
              trailing: _trailingList[index],
              onTap: () {
                Get.to(() => MessagePage());
              },
            ),
          );
        },
      ),
    );
  }
}
