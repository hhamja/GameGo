import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index.dart';

//당근마켓 같은 채팅시스템 구현. 외부에서 가져다 쓰고 추후에 사용자가 많아지면 직접 구현.
class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  /* Chat Controller */
  final ChatController _chat = Get.put(ChatController());
  bool _click = true;
  /* 현재 유저의 uid */
  final _currentUid = FirebaseAuth.instance.currentUser?.uid.toString();
  @override
  void initState() {
    _chat.chatRoomList.bindStream(_chat.readAllChatList(_currentUid));
    super.initState();
  }

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
      body: Obx(
        () => ListView.builder(
          itemCount: _chat.chatRoomList.length,
          itemBuilder: (BuildContext context, int index) {
            //상대유저 UID
            final peerUserId = _chat.chatRoomList[index].peerUserId!;
            print(peerUserId);
            _chat.getUserInfo(peerUserId); //상대유저정보받기
            // 마지막 대화내용
            final lastContent = _chat.chatRoomList[index].lastContent ?? '';
            // 최근 날짜
            final updatedAt = _chat.chatRoomList[index].updatedAt ?? '';
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
                        _chat.chatRoomList.removeAt(index);
                      });
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(), // 상대 유저 프로필 사진
                title: Text(
                  _chat.userInfo['userName'] ?? '(알수없음)',
                  maxLines: 1,
                ), // 상대 유저 이름
                subtitle: Text(
                  lastContent,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ), // 채팅방 마지막 대화 내용 요약
                trailing: Text(
                  '1일전',
                  maxLines: 1,
                ), // 최근 대화 날짜 (며칠 전)
                onTap: () {
                  Get.to(
                    () => MessagePage(),
                    arguments: {'uid': peerUserId}, //uid값 전달
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
