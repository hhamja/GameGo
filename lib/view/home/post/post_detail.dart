import 'package:mannergamer/utilites/index/index.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
            padding:
                EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AppSpaceData.screenPadding),
                  onTap: _auth.currentUser!.uid == _post.postInfo.uid
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  // 매너나이
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_post.mannerAge.toString() + '세',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.25,
                            color: mannerAgeColor,
                          )),
                      Text(
                        '(매너나이)',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: appBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 제목
                      Text(
                        _post.postInfo.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 5.sp),
                      // 게임모드, 포지션, 티어
                      Row(
                        children: [
                          Text(
                            '${_post.postInfo.gamemode}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _post.postInfo.position != null
                                ? ' · ${_post.postInfo.position}'
                                : '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _post.postInfo.tear != null
                                ? ' · ${_post.postInfo.tear}'
                                : '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpaceData.heightLarge),
                      // 본문글
                      Text(
                        '${_post.postInfo.maintext}',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium,
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
              ],
            ),
          ),
        ),
      ),
      bottomSheet:
          // 나의 게시글 이라면?
          _auth.currentUser!.uid == _post.postInfo.uid
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.all(
                    AppSpaceData.screenPadding,
                  ),
                  child: Container(
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
                                  idFrom: _auth.currentUser!.uid,
                                  idTo: _post.postInfo.uid,
                                  createdAt: Timestamp.now(),
                                );
                                // NotificationModel 인스턴스
                                final NotificationModel _ntfModel =
                                    NotificationModel(
                                  // 관심버튼 누른 uid
                                  idFrom: _auth.currentUser!.uid,
                                  // 게시자 uid
                                  idTo: _post.postInfo.uid,
                                  // 관심버튼 누른 유저이름
                                  userName: _auth.currentUser!.displayName!,
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
                                  // true => filled
                                  ? Icon(
                                      Icons.favorite,
                                      color: appPrimaryColor,
                                      size: 25.sp,
                                    )
                                  // false => not filled
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      size: 23.sp,
                                      color: appBlackColor,
                                    ),
                            ),
                          ),
                        ),
                        // 채팅하기 버튼
                        Expanded(
                          flex: 5,
                          child: CustomFullFilledTextButton(
                            '채팅하기',
                            () {
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  // 게시물 오른쪽 상단의 아이콘 클릭 시  바텀시트 호출
  openPostBottomSheet() {
    // 나의 게시글인지 타인 게시글인지 판단
    if (_auth.currentUser!.uid == _post.postInfo.uid) {
      // 나의 게시글
      return Get.bottomSheet(
        Container(
          margin: EdgeInsets.all(AppSpaceData.screenPadding * 0.5),
          decoration: BoxDecoration(
            color: appWhiteColor,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          // 아이템 개수*50 + 10 (위아래 공간 각  5)
          height: 110.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtomSheet('게시글 수정', appBlackColor, () async {
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
              CustomButtomSheet('삭제', appRedColor, () async {
                Get.back();
                // 삭제에 대해 재요청하는 다이어로그 띄우기
                await Get.dialog(DeleteDialog(), arguments: {'postId': postId});
              }),
            ],
          ),
        ),
      );
    } else {
      // 타인의 게시물인 경우
      return Get.bottomSheet(
        Container(
          margin: EdgeInsets.all(AppSpaceData.screenPadding * 0.5),
          decoration: BoxDecoration(
            color: appWhiteColor,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          // 아이템 개수*50 + 10 (위아래 공간 각  5)
          height: 60.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtomSheet('신고하기', appBlackColor, () {
                // 다이어로그 끄기
                Get.back();
                // 신고하기 페이지로 이동
                Get.toNamed(
                  '/report',
                  arguments: {
                    'postId': postId,
                    // 신고 받는 사람의 uid
                    'uid': _post.postInfo.uid,
                  },
                );
              }),
            ],
          ),
        ),
      );
    }
  }
}
