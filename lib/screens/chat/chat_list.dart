import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index.dart';

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
        () => ListView.builder(
          itemCount: _chat.chatRoomList.length,
          itemBuilder: (BuildContext context, int index) {
            //상대유저 정보(프로필, 이름, 매너나이)
            // == 를 != 로 수정해야한다
            Map<String, dynamic> contactUser =
                _chat.chatRoomList[index].userList.firstWhere((element) =>
                    element['id'] == FirebaseAuth.instance.currentUser!.uid);

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
                /*  상대 유저 이름 */
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
                /* 최근 대화 날짜 (며칠 전) */
                trailing: Text(
                  Jiffy(_chat.chatRoomList[index].updatedAt.toDate()).fromNow(),
                ),
                onTap: () {
                  Get.to(
                    () => MessagePage(),
                    arguments: {
                      //상대유저정보 전달
                      'userName': contactUser['userName'],
                      'profileUrl': contactUser['profileUrl'],
                      'mannerAge': contactUser['mannerAge'],
                      'index': index,
                      'chatRoomId': _chat.chatRoomList[index].id,
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
