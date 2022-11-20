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
  /* 현재유저 uid */
  final _currentUid = FirebaseAuth.instance.currentUser!.uid;
  List _contactUser = [];
  String _unReadCount = '';
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
            icon: Icon(Icons.notifications_none_outlined),
            //아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          ),
        ],
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await _chat.chatRoomList; //채팅리스트 새로고침
          },
          displacement: 0,
          child: ListView.separated(
            itemCount: _chat.chatRoomList.length,
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
            itemBuilder: (BuildContext context, int index) {
              final _chatList = _chat.chatRoomList[index];
              /* 상대유저 정보 
              * 두개의 List에서 Uid값이 현재uid랑 다르면 상대유저정보의 List */
              if (_chatList.postingUser[0] != _currentUid) {
                _contactUser = _chatList.postingUser;
              }
              if (_chatList.contactUser[0] != _currentUid) {
                _contactUser = _chatList.contactUser;
              }

              String _time =
                  Jiffy(_chatList.updatedAt.toDate()).fromNow(); //'-전'시간표시
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.2, //한개당 0.2, 삭제버튼 추가시 0.4로 수정할 것
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
                    // /* 채팅 나가기 (DB에서 삭제 X)*/
                    // SlidableAction(
                    //   onPressed: (_) {},
                    //   backgroundColor: Color(0xFFFE4A49),
                    //   foregroundColor: Colors.white,
                    //   icon: Icons.delete,
                    // ),
                  ],
                ),
                child: ListTile(
                  /* 상대 유저 프로필 사진 */
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_contactUser[1]),
                  ),
                  /* 이름 · 시간 */
                  title: Text(
                    _contactUser[2],
                    maxLines: 1,
                  ),
                  /* 마지막 대화 내용 */
                  subtitle: Text(
                    _chatList.lastContent,
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
                            /* 위에서 뽑은 상대유저의 uid 넣어서 안읽은 메시지 수 받음 */
                            _chatList.unReadCount['${_contactUser[0]}']
                                .toString(),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )), // 읽지 않은 메시지 알려주는 빨간숫자
                    ],
                  ),
                  onTap: () {
                    Get.toNamed(
                      '/chatscreen',
                      arguments: {
                        'profileUrl': _contactUser[1],
                        'userName': _contactUser[2],
                        'mannerAge': _contactUser[3],
                        'chatRoomId': _chatList.chatRoomId,
                        'postId': _chatList.postId,
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
