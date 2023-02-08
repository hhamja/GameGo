import 'package:mannergamer/utilites/index/index.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostController _post = Get.find<PostController>();
  final FavoriteController _favorite = Get.put(FavoriteController());
  // PostList Page 와 Favorite 에서 PostId값 전달 받음
  final String postId = Get.arguments['postId'];

  @override
  void initState() {
    super.initState();
    // postInfo에 게시글 데이터 담기
    _post.getPostInfoByid(postId);
    // 하트아이콘에 적용한 초기 bool값 반환
    _favorite.isFavoritePost(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 외부SNS로 해당 게시물 공유버튼
          // IconButton(onPressed: () {}, icon: Icon(Icons.ios_share)),
          // 내 게시글인 경우 : openMypostBottomSheet() : openBottomSheet()
          IconButton(
              onPressed: openPostBottomSheet, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16),
                  onTap: CurrentUser.uid == _post.postInfo.uid
                      // 나의 게시글 : 프로필 이동 X
                      ? null
                      // 다른 유저 게시글 : 해당 유저 프로필로 이동
                      : () {
                          Get.toNamed(
                            // 상대 프로필 페이지로 이동
                            '/userProfile',
                            arguments: {
                              'profileUrl': _post.postInfo.profileUrl,
                              'userName': _post.postInfo.userName,
                              'mannerAge': _post.mannerAge,
                              'uid': _post.postInfo.uid,
                            },
                          );
                        },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_post.postInfo.profileUrl),
                  ),
                  title: Text(
                    _post.postInfo.userName,
                  ),

                  //매너나이
                  //탈퇴유저는 null이므로 ' - 세'로 표시
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_post.mannerAge.toString() + ' 세'),
                      Text(
                        '매너나이',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 30, 16, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 제목
                      Text(
                        _post.postInfo.title,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // 게임모드, 포지션, 티어
                      Row(
                        children: [
                          Text(
                            '${_post.postInfo.gamemode}',
                            style:
                                TextStyle(fontSize: 15, color: appBlackColor),
                          ),
                          Text(
                            _post.postInfo.position != null
                                ? ' · ${_post.postInfo.position}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: appBlackColor),
                          ),
                          Text(
                            _post.postInfo.tear != null
                                ? ' · ${_post.postInfo.tear}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: appBlackColor),
                          ),
                        ],
                      ),
                      // 본문글
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          '${_post.postInfo.maintext}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // SizedBox(height: 30),
                      // 채팅 · 좋아요 · 조회 수
                      // Text('채팅 1 · 관심 1 · 조회 82',
                      //     style: TextStyle(fontSize: 15, color: appBlackColor54),
                      //     textAlign: TextAlign.right,
                      //     textWidthBasis: TextWidthBasis.longestLine),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet:
          // 나의 게시글 이라면?
          CurrentUser.uid == _post.postInfo.uid
              ? SizedBox.shrink()
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      width: double.infinity,
                      color: appWhiteColor,
                      child: Row(
                        children: [
                          // 관심(하트)
                          Expanded(
                            flex: 2,
                            child: Obx(
                              () => IconButton(
                                onPressed: () async {
                                  // favoriteModel 인스턴스
                                  final FavoriteModel _favoriteModel =
                                      FavoriteModel(
                                    postId: postId,
                                    idFrom: CurrentUser.uid,
                                    idTo: _post.postInfo.uid,
                                    createdAt: Timestamp.now(),
                                  );
                                  // NotificationModel 인스턴스
                                  final NotificationModel _ntfModel =
                                      NotificationModel(
                                    // 관심버튼 누른 uid
                                    idFrom: CurrentUser.uid,
                                    // 게시자 uid
                                    idTo: _post.postInfo.uid,
                                    // 관심버튼 누른 유저이름
                                    userName: CurrentUser.name,
                                    postId: postId,
                                    chatRoomId: '', // 대상이 되는 채팅방 없음
                                    postTitle: _post.postInfo.title,
                                    content: '',
                                    type: 'favorite',
                                    createdAt: Timestamp.now(),
                                  );
                                  //관심게시글 등록
                                  await _favorite.clickfavoriteButton(
                                      _favoriteModel, _ntfModel);
                                },
                                icon: _favorite.isFavorite.value
                                    //true => 파란색 하트
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.blue,
                                      )
                                    //false => 빈 하트
                                    : Icon(Icons.favorite_border_outlined),
                              ),
                            ),
                          ),
                          // 채팅하기 버튼 -> 게시글에서 이동하는 채팅페이지로 이동
                          Expanded(
                            flex: 5,
                            child: TextButton(
                              onPressed: () {
                                Get.to(
                                  () => ChatScreenPageFromPost(),
                                  arguments: {
                                    'postId': _post.postInfo.postId,
                                    'uid': _post.postInfo.uid,
                                    'userName': _post.postInfo.userName,
                                    'mannerAge': _post.mannerAge,
                                    'profileUrl': _post.postInfo.profileUrl,
                                  },
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                backgroundColor: Colors.blue,
                              ),
                              child: Text('채팅하기',
                                  style: TextStyle(color: appWhiteColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  // 게시물 오른쪽 상단의 아이콘 클릭 시  바텀시트 호출
  openPostBottomSheet() {
    // 나의 게시물인 경우
    if (CurrentUser.uid == _post.postInfo.uid) {
      return Get.bottomSheet(
        Container(
          color: appWhiteColor,
          height: 180,
          child: Column(
            children: [
              CustomButtomSheet('게시글 수정', Colors.blue, () async {
                Get.back();
                // 나의 게시물 수정 페이지로 이동
                await Get.to(() => EditPostPage(), arguments: {
                  'postId': postId,
                  'maintext': _post.postInfo.maintext,
                  'title': _post.postInfo.title,
                  'gamemode': _post.postInfo.gamemode,
                  'position': _post.postInfo.position,
                  'tear': _post.postInfo.tear,
                });
              }),
              CustomButtomSheet('삭제', Colors.redAccent, () async {
                Get.back();
                // 삭제에 대해 재요청하는 다이어로그 띄우기
                await Get.dialog(DeleteDialog(), arguments: {'postId': postId});
              }),
              // 바텀시트 내리기
              CustomButtomSheet('취소', Colors.blue, () => Get.back()),
            ],
          ),
        ),
      );
    } else {
      // 타인의 게시물인 경우
      return Get.bottomSheet(
        Container(
          color: appWhiteColor,
          height: 120,
          child: Column(
            children: [
              CustomButtomSheet('신고하기', Colors.blue, () {
                Get.back();
                Get.toNamed(
                  '/report',
                  arguments: {
                    'postId': postId,
                    //신고 받는 사람의 uid
                    'uid': _post.postInfo.uid,
                  },
                );
              }), //신고하기 페이지로 이동
              // CustomButtomSheet(
              //     "'${_post.postInfo.userName}' 차단하기", Colors.redAccent, () {
              //   Get.back();
              // }), // 사용자 차단 (나중)
              //
              //바텀시트 내리기
              CustomButtomSheet('취소', Colors.blue, () => Get.back()),
            ],
          ),
        ),
      );
    }
  }
}
