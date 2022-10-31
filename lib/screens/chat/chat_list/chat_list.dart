import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index/index.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  /* Chat Controller */
  final ChatController _chat = Get.put(ChatController());
  /*  */
  bool _click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
        actions: [
          IconButton(
            onPressed: () => {Get.toNamed('/notification')},
            icon: Icon(Icons
                .notifications_none_outlined), //아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          ),
        ],
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await _chat.chatRoomList; //채팅리스트 새로고침
          },
          displacement: 0,
          child: ListView.builder(
            itemCount: _chat.chatRoomList.length,
            itemBuilder: (BuildContext context, int index) {
              //상대유저 정보(프로필, 이름, 매너나이)
              // == 를 != 로 수정해야한다
              Map<String, dynamic> contactUser =
                  _chat.chatRoomList[index].userList.firstWhere((element) =>
                      element['id'] != FirebaseAuth.instance.currentUser!.uid);
              String _time =
                  Jiffy(_chat.chatRoomList[index].updatedAt.toDate()).fromNow();
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: DrawerMotion(),
                  children: [
                    /* 알림 on/off */
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
                    /* 채팅 나가기 (DB에서 삭제 X)*/
                    SlidableAction(
                      onPressed: (_) {},
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: ListTile(
                  /* 상대 유저 프로필 사진 */
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contactUser['profileUrl']),
                  ),
                  /* 이름 · 시간 */
                  title: Text(
                    contactUser['userName'],
                    maxLines: 1,
                  ),
                  /* 마지막 대화 내용 */
                  subtitle: Text(
                    _chat.chatRoomList[index].lastContent,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  /* 최근시간 · 읽지 않은 메시지 수 */
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _time,
                        style: TextStyle(fontSize: 10),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                          child: Text(
                            '1',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )), // 읽지 않은 메시지 알려주는 빨간숫자
                    ],
                  ),
                  onTap: () {
                    Get.to(
                      () => MessagePage(),
                      arguments: {
                        'userName': contactUser['userName'],
                        'profileUrl': contactUser['profileUrl'],
                        'mannerAge': contactUser['mannerAge'],
                        'index': index,
                        'chatRoomId': _chat.chatRoomList[index].id,
                      }, //상대유저정보 전달
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
