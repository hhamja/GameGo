import 'package:mannergamer/utilites/index/index.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostController _post = Get.find<PostController>();

  final FavoriteController _ = Get.put(FavoriteController());

  /* 해당 게시물의 lisview에서의 index값 전달 받음 */
  final int index = Get.arguments['index'];

  /* 현재 유저의 uid */
  final String currentUid = FirebaseAuth.instance.currentUser!.uid;
  var postId;

  @override
  void initState() {
    super.initState();
    postId = _post.postList[index].postId;
    _.isFavoritePost(currentUid, postId); //하트아이콘에 적용한 초기 bool값 반환
  }

  @override
  Widget build(BuildContext context) {
    print(index);
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
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(_post.postList[index].profileUrl),
                  ),
                  title: Text(
                    _post.postList[index].userName,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* 유저 매너나이 */
                      // 유저 DB에서 uid로 해당 유저의 매너나이 불러오기
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_post.postList[index].mannerAge),
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
                        _post.postList[index].title,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      /* 게임모드, 포지션, 티어 */
                      Row(
                        children: [
                          Text(
                            '${_post.postList[index].gamemode}',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            _post.postList[index].position != null
                                ? ' · ${_post.postList[index].position}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            _post.postList[index].tear != null
                                ? ' · ${_post.postList[index].tear}'
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
                          '${_post.postList[index].maintext}',
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
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                /* 좋아요(하트) */
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => IconButton(
                      onPressed: () async {
                        await _.favoritePost(currentUid, postId);
                      },
                      icon: _.isFavorite.value
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
                        () => MessagePageFromPost(),
                        arguments: {
                          'postId': _post.postList[index].postId,
                          'uid': _post.postList[index].uid,
                          'userName': _post.postList[index].userName,
                          'mannerAge': _post.postList[index].mannerAge,
                          'profileUrl': _post.postList[index].profileUrl,
                        }, //채팅페이지에 필요한 데이터 전달
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('채팅하기', style: TextStyle(color: Colors.white)),
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
    if (currentUid == _post.postList[index].uid) {
      return Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 180,
          child: Column(
            children: [
              ButtomSheetContent('게시물 수정', Colors.blue, () async {
                Get.back();
                await Get.to(
                  () => EditPostPage(),
                  arguments: index,
                );
              }), //자기 게시물 수정 페이지로 이동
              ButtomSheetContent('삭제', Colors.redAccent, () async {
                Get.back();
                await Get.dialog(DeleteDialog(), arguments: {'index': index});
              }), //게시물 DB에서 삭제
              ButtomSheetContent('취소', Colors.blue, () => Get.back()),
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
          height: 180,
          child: Column(
            children: [
              ButtomSheetContent('이 사용자의 글 보지 않기', Colors.blue, () {
                Get.back();
              }), // 글 노출 안하는 (나중)
              ButtomSheetContent('신고하기', Colors.redAccent, () {
                Get.back();
                Get.to(ReportListPage());
              }), //게시물 신고하기 페이지로 이동
              ButtomSheetContent('취소', Colors.blue, () => Get.back()),
              //바텀시트 내리기
            ],
          ),
        ),
      );
    }
  }
}
