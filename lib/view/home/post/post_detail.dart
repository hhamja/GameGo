import 'package:mannergamer/utilites/index/index.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostController _post = Get.find<PostController>();
  final FavoriteController _favorite = Get.put(FavoriteController());
  /* PostList Page 와 Favorite 에서 PostId값 전달 받음 */
  final String postId = Get.arguments['postId'];

  @override
  void initState() {
    super.initState();
    _post.getPostInfoByid(postId); //postInfo에 게시글 데이터 담기
    _favorite.isFavoritePost(CurrentUser.uid, postId); //하트아이콘에 적용한 초기 bool값 반환
  }

  @override
  Widget build(BuildContext context) {
    print(postId);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // /* 외부SNS로 해당 게시물 공유버튼 */
          // IconButton(onPressed: () {}, icon: Icon(Icons.ios_share)),
          /* 내게시물 ? openMypostBottomSheet() : openBottomSheet() */
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
                  onTap: CurrentUser.uid == _post.postInfo['uid']
                      ? null //나의게시물? 프로필 이동 X
                      : () {
                          Get.toNamed('/userProfile', arguments: {
                            'profileUrl': _post.postInfo['profileUrl'],
                            'userName': _post.postInfo['userName'],
                            'mannerAge': _post.postInfo['mannerAge']
                          }); //다른유저 게시물 ? 해당 유저 프로필로 이동
                        },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_post.postInfo['profileUrl']),
                  ),
                  title: Text(
                    _post.postInfo['userName'],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* 유저 매너나이 */
                      // 유저 DB에서 uid로 해당 유저의 매너나이 불러오기
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_post.postInfo['mannerAge'] + '세'),
                          Icon(Icons.child_care),
                        ],
                      ),
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
                  padding: EdgeInsets.fromLTRB(16, 25, 16, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /* 제목 */
                      Text(
                        _post.postInfo['title'],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      /* 게임모드, 포지션, 티어 */
                      Row(
                        children: [
                          Text(
                            '${_post.postInfo['gamemode']}',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            _post.postInfo['position'] != null
                                ? ' · ${_post.postInfo['position']}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            _post.postInfo['tear'] != null
                                ? ' · ${_post.postInfo['tear']}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      /* 본문글 */
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          '${_post.postInfo['maintext']}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),

                      // SizedBox(height: 30),
                      /* 채팅 · 좋아요 · 조회 수 */
                      // Text('채팅 1 · 관심 1 · 조회 82',
                      //     style: TextStyle(fontSize: 15, color: Colors.black54),
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
                /* 신고하기 */
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  onTap: () {
                    Get.to(ReportListPage());
                  },
                  title: Text(
                    '광           고',
                    textAlign: TextAlign.center,
                  ),
                  // trailing: Icon(Icons.keyboard_arrow_right_outlined),
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
          /* 나의 게시글 이라면? */
          CurrentUser.uid == _post.postInfo['uid']
              ? SizedBox.shrink()
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          /* 관심(하트) */
                          Expanded(
                            flex: 2,
                            child: Obx(
                              () => IconButton(
                                onPressed: () async {
                                  //NotificationModel 인스턴스
                                  final NotificationModel _ntfModel =
                                      NotificationModel(
                                    idTo: _post.postInfo['uid'], //게시자 uid
                                    idFrom: CurrentUser.uid, //관심버튼 누른 uid
                                    userName: FirebaseAuth.instance.currentUser!
                                            .displayName ??
                                        '(이름없음)',
                                    type: 'favorite',
                                    postId: postId,
                                    postTitle: _post.postInfo['title'], //게시글 제목
                                    createdAt: Timestamp.now(),
                                  );
                                  //관심게시글 등록
                                  await _favorite.favoritePost(
                                      CurrentUser.uid, postId, _ntfModel);
                                },
                                icon: _favorite.isFavorite.value
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.blue,
                                      ) //true => 파란색 하트
                                    : Icon(Icons
                                        .favorite_border_outlined), //false => 빈 하트    ,
                              ),
                            ),
                          ),
                          /* 채팅하기 버튼 -> Chat Page From Post 이동 */
                          Expanded(
                            flex: 5,
                            child: TextButton(
                              onPressed: () {
                                Get.to(
                                  () => ChatScreenPageFromPost(),
                                  arguments: {
                                    'postId': _post.postInfo['postId'],
                                    'uid': _post.postInfo['uid'],
                                    'userName': _post.postInfo['userName'],
                                    'mannerAge': _post.postInfo['mannerAge'],
                                    'profileUrl': _post.postInfo['profileUrl'],
                                  }, //채팅페이지에 필요한 데이터 전달
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                backgroundColor: Colors.blue,
                              ),
                              child: Text('채팅하기',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  /* 게시물 오른쪽 상단의 아이콘 클릭 시  바텀시트 호출 */
  openPostBottomSheet() {
    /* 나의 게시물인 경우 */
    if (CurrentUser.uid == _post.postInfo['uid']) {
      return Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 180,
          child: Column(
            children: [
              CustomButtomSheet('게시글 수정', Colors.blue, () async {
                Get.back();
                await Get.to(() => EditPostPage(), arguments: {
                  'postId': postId,
                  'maintext': _post.postInfo['maintext'],
                  'title': _post.postInfo['title'],
                  'gamemode': _post.postInfo['gamemode'],
                  'position': _post.postInfo['position'],
                  'tear': _post.postInfo['tear'],
                });
              }), //자기 게시물 수정 페이지로 이동
              CustomButtomSheet('삭제', Colors.redAccent, () async {
                Get.back();
                await Get.dialog(DeleteDialog(), arguments: {'postId': postId});
              }), //게시물 DB에서 삭제
              CustomButtomSheet('취소', Colors.blue, () => Get.back()),
              //바텀시트 내리기
            ],
          ),
        ),
      );
    } /* 타인의 게시물인 경우 */
    else {
      return Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 120,
          child: Column(
            children: [
              CustomButtomSheet('신고하기', Colors.blue, () {
                Get.back();
                Get.toNamed(
                  '/report',
                  arguments: {
                    'postId': postId,
                  },
                );
              }), //신고하기 페이지로 이동
              // CustomButtomSheet(
              //     "'${_post.postInfo['userName']}' 차단하기", Colors.redAccent, () {
              //   Get.back();
              // }), // 사용자 차단 (나중)
              CustomButtomSheet('취소', Colors.blue, () => Get.back()),
              //바텀시트 내리기
            ],
          ),
        ),
      );
    }
  }
}
