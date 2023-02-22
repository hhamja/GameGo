import 'package:flutter/cupertino.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class ChatListPage extends GetView<ChatController> {
  ChatListPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatController _c = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    // 제목 텍스트 스타일
    final TextStyle _userNameTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      letterSpacing: Theme.of(context).textTheme.titleSmall!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight,
      color: Theme.of(context).textTheme.titleSmall!.color,
    );
    // 서브 텍스트 스타일
    final TextStyle _contentTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
      letterSpacing: Theme.of(context).textTheme.bodySmall!.letterSpacing,
      fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
      color: appGreyColor,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => {
              Get.toNamed('/notification'),
            },
            icon: Icon(CupertinoIcons.bell),
          ),
        ],
      ),
      body: Obx(
        () => _c.chatRoomList.isEmpty
            // 참여중인 채팅방이 없는 경우
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '참여 중인 채팅방이 없어요.',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '다른 유저에게 채팅을 보내보세요!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            // 채팅방이 있는 경우
            : ListView.builder(
                itemCount: _c.chatRoomList.length,
                itemBuilder: (BuildContext context, int index) {
                  final ChatRoomModel _chatList = _c.chatRoomList[index];
                  String _time = Jiffy(_chatList.updatedAt.toDate()).fromNow();
                  // 상대유저 정보, [uid, profileUrl, userName] 순서
                  List _chatPartner = [];
                  // 채팅 상대방 List에 [uid, 프로필url, 이름]순으로 넣기
                  if (_chatList.postingUid != _auth.currentUser!.uid &&
                      _chatList.contactUid == _auth.currentUser!.uid) {
                    // 나 == contactUser, 상대방 == postingUser인 경우
                    // postingUser 데이터를 담기
                    _chatPartner.addAll([
                      _chatList.postingUid,
                      _chatList.postingUserProfileUrl,
                      _chatList.postingUserName
                    ]);
                  } else if (_chatList.postingUid == _auth.currentUser!.uid &&
                      _chatList.contactUid != _auth.currentUser!.uid) {
                    // 나 == postingUser인, 상대방 == contactUser 경우
                    // contactUser 데이터를 담기
                    _chatPartner.addAll([
                      _chatList.contactUid,
                      _chatList.contactUserProfileUrl,
                      _chatList.contactUserName
                    ]);
                  }
                  return
                      // Slidable(
                      //   endActionPane: ActionPane(
                      //     extentRatio: 0.2, //한개당 0.2, 삭제버튼 추가시 0.4로 수정할 것
                      //     motion: DrawerMotion(),
                      //     children: [
                      //       // 알림 on/off
                      //       SlidableAction(
                      //         backgroundColor: Colors.grey,
                      //         foregroundColor: appWhiteColor,
                      //         icon: (_click == true)
                      //             ? CupertinoIcons.bell_solid
                      //             : CupertinoIcons.bell_slash_fill,
                      //         onPressed: (_) {
                      //           setState(() {
                      //             _click = !_click;
                      //           });
                      //         },
                      //       ),
                      //       // // 채팅 나가기 (DB에서 삭제 X)*/
                      //       // SlidableAction(
                      //       //   onPressed: (_) async {
                      //       //     await _chat.chatRoomList.removeAt(index);
                      //       //     await _chat.deleteChat(_chatList.chatRoomId);
                      //       //   },
                      //       //   backgroundColor: Color(0xFFFE4A49),
                      //       //   foregroundColor: appWhiteColor,
                      //       //   icon: Icons.delete,
                      //       // ),
                      //     ],
                      //   ),
                      //   child:
                      Opacity(
                    // 투명도 설정
                    // 비탈퇴유저는 정상수치인 1, 탈퇴유저는 0.5,
                    opacity: _chatList.isActive ? 1 : 0.5,
                    child: InkWell(
                      onTap: () async {
                        // 페이지 이동
                        Get.toNamed(
                          // 상대가 탈퇴 유저인지 확인
                          _chatList.isActive
                              // 탈퇴유저 아님 : 일반적인 채팅 페이지
                              ? '/chatscreen'
                              // 탈퇴유저임 : 탈퇴유저전용 채팅 페이지
                              : '/noUserChatScreen',
                          arguments: {
                            'chatRoomId': _chatList.chatRoomId,
                            'postId': _chatList.postId,
                            'uid': _chatPartner[0],
                            'profileUrl': _chatPartner[1],
                            'userName': _chatPartner[2],
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                          AppSpaceData.screenPadding,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // 상대 유저 프로필
                            Container(
                              height: 48,
                              width: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  _chatList.isActive
                                      // 상대 비탈퇴 : 상대의 프로필
                                      ? _chatPartner[1]
                                      // 상대 탈퇴 : 기본 프로필
                                      : DefaultProfle.url,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: AppSpaceData.screenPadding * .8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 상대이름
                                    Text(
                                      _chatPartner[2],
                                      maxLines: 1,
                                      style: _userNameTextStyle,
                                    ),
                                    // 마지막 채팅
                                    Text(
                                      _chatList.lastContent,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: _contentTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // 최근시간 · 읽지 않은 메시지 수
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: appGreyColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                // 안읽은 메시지 수 0개가 아닐때만 표시
                                _chatList.unReadCount[
                                            '${_auth.currentUser!.uid}'] !=
                                        0
                                    ? Container(
                                        height: 18,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: appPrimaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            // 읽지 않은 메시지 알려주는 빨간숫자
                                            _chatList.unReadCount[
                                                    '${_auth.currentUser!.uid}']
                                                .toString(),
                                            style: TextStyle(
                                              height: 1.2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: appWhiteColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
