import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index/index.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final ChatController _chat = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
        actions: [
          // 아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          IconButton(
            onPressed: () => {
              Get.toNamed('/notification'),
            },
            icon: Icon(
              CupertinoIcons.bell,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: _chat.chatRoomList.length,
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
          itemBuilder: (BuildContext context, int index) {
            final _chatList = _chat.chatRoomList[index];
            // '-전'시간표시
            String _time = Jiffy(_chatList.updatedAt.toDate()).fromNow();

            // 상대유저 정보 담기
            // 두개의 List에서 Uid값이 현재uid랑 다르면 상대유저정보의 List
            List _chatPartner = [];
            // 나 == contactUser, 상대방 == postingUser인 경우
            if (_chatList.postingUid != CurrentUser.uid &&
                _chatList.contactUid == CurrentUser.uid) {
              // 채팅 상대방 List에 [uid, 프로필url, 이름]순으로 넣기
              _chatPartner.addAll([
                _chatList.postingUid,
                _chatList.postingUserProfileUrl,
                _chatList.postingUserName
              ]);
              print(_chatPartner);
            }
            // 나 == postingUser인, 상대방 == contactUser 경우
            else if (_chatList.postingUid == CurrentUser.uid &&
                _chatList.contactUid != CurrentUser.uid) {
              // 채팅 상대방 List에 [uid, 프로필url, 이름]순으로 넣기
              _chatPartner.addAll([
                _chatList.contactUid,
                _chatList.contactUserProfileUrl,
                _chatList.contactUserName
              ]);
            }
            null;
            return
                // Slidable(
                //   endActionPane: ActionPane(
                //     extentRatio: 0.2, //한개당 0.2, 삭제버튼 추가시 0.4로 수정할 것
                //     motion: DrawerMotion(),
                //     children: [
                //       /* 알림 on/off */
                //       SlidableAction(
                //         backgroundColor: Colors.grey,
                //         foregroundColor: Colors.white,
                //         icon: (_click == true)
                //             ? CupertinoIcons.bell_solid
                //             : CupertinoIcons.bell_slash_fill,
                //         onPressed: (_) {
                //           setState(() {
                //             _click = !_click;
                //           });
                //         },
                //       ),
                //       // /* 채팅 나가기 (DB에서 삭제 X)*/
                //       // SlidableAction(
                //       //   onPressed: (_) async {
                //       //     await _chat.chatRoomList.removeAt(index);
                //       //     await _chat.deleteChat(_chatList.chatRoomId);
                //       //   },
                //       //   backgroundColor: Color(0xFFFE4A49),
                //       //   foregroundColor: Colors.white,
                //       //   icon: Icons.delete,
                //       // ),
                //     ],
                //   ),
                //   child:
                Opacity(
              /// 투명도 설정
              /// 비탈퇴유저는 정상수치인 1, 탈퇴유저는 0.5,
              opacity: _chatList.isActive ? 1 : 0.5,
              child: ListTile(
                // 상대 유저 프로필 사진
                leading: CircleAvatar(
                  // 상대가 탈퇴가 아님 : 상대 프로필 표시
                  // 상대가 탈퇴유저 : 기본 프로필 표시
                  backgroundImage: NetworkImage(
                      _chatList.isActive ? _chatPartner[1] : DefaultProfle.url),
                ),
                // 이름 · 시간
                title: Text(
                  _chatPartner[2],
                  maxLines: 1,
                ),
                // 마지막 대화 내용
                subtitle: Text(
                  _chatList.lastContent,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                // 최근시간 · 읽지 않은 메시지 수
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _time,
                      style: TextStyle(fontSize: 10),
                    ),
                    // 안읽은 메시지 수 0개가 아닐때만 표시
                    _chatList.unReadCount['${CurrentUser.uid}'] != 0
                        ? CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(
                              // 읽지 않은 메시지 알려주는 빨간숫자
                              _chatList.unReadCount['${CurrentUser.uid}']
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                onTap: () async {
                  // 페이지 이동
                  Get.toNamed(
                    // 상대가 탈퇴 유저인지 확인
                    _chatList.isActive
                        // 탈퇴유저 아님
                        ? '/chatscreen'
                        // 탈퇴유저임
                        : '/noUserChatScreen',
                    arguments: {
                      'chatRoomId': _chatList.chatRoomId,
                      'postId': _chatList.postId,
                      // 상대유저 uid, 프로필, 닉네임
                      'uid': _chatPartner[0],
                      'profileUrl': _chatPartner[1],
                      'userName': _chatPartner[2],
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
