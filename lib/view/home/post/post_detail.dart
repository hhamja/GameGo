import 'package:gamegoapp/utilites/index/index.dart';

class PostDetailPage extends StatelessWidget {
  PostDetailPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DetailPostController _c = Get.put(DetailPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 외부SNS로 해당 게시물 공유버튼
          // IconButton(onPressed: () {}, icon: Icon(Icons.ios_share)),
          // 내 게시글인 경우 : openMypostBottomSheet() : openBottomSheet()
          IconButton(
            onPressed: openPostBottomSheet,
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: _c.obx(
        onLoading: SizedBox.shrink(),
        // 값이 없을 때
        onEmpty: Center(
          child: Text(
            '존재하지 않는 게시글 입니다.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // 에러가 떴을 때
        onError: (error) => Center(
          child: Text(
            '게시글을 불러올 수 없습니다.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // 값이 존재할 때
        (state) => SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AppSpaceData.screenPadding),
                  onTap: () async {
                    Get.toNamed(
                      // 상대 프로필 페이지로 이동
                      '/userProfile',
                      arguments: {
                        'profileUrl': _c.postInfo.profileUrl,
                        'userName': _c.postInfo.userName,
                        'mannerLevel': _c.level,
                        'uid': _c.postInfo.uid,
                      },
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_c.postInfo.profileUrl),
                  ),
                  title: Text(
                    _c.postInfo.userName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  // 매너Lv
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: _c.getUserMannerLevel(_c.postInfo.uid),
                        builder: (context, snapshot) => Text(
                          'Lv.${_c.level}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.25,
                            color: mannerLevelColor,
                          ),
                        ),
                      ),
                      Text(
                        '(매너레벨)',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: appDarkGrey,
                          letterSpacing: 0.5.sp,
                          height: 0.9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 제목
                      Text(
                        _c.postInfo.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 5.sp),
                      // 게임모드, 포지션, 티어
                      Row(
                        children: [
                          Text(
                            '${_c.postInfo.gamemode}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _c.postInfo.position != null
                                ? ' · ${_c.postInfo.position}'
                                : '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _c.postInfo.tear != null
                                ? ' · ${_c.postInfo.tear}'
                                : '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpaceData.heightLarge),
                      // 본문글
                      Text(
                        '${_c.postInfo.maintext}',
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
      bottomSheet: Padding(
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
                      final FavoriteModel _favoriteModel = FavoriteModel(
                        postId: _c.postId,
                        idFrom: _auth.currentUser!.uid,
                        idTo: _c.postInfo.uid,
                        createdAt: Timestamp.now(),
                      );
                      // NotificationModel 인스턴스
                      final NotificationModel _ntfModel = NotificationModel(
                        // 관심버튼 누른 uid
                        idFrom: _auth.currentUser!.uid,
                        // 게시자 uid
                        idTo: _c.postInfo.uid,
                        // 관심버튼 누른 유저이름
                        userName: _auth.currentUser!.displayName!,
                        postId: _c.postId,
                        chatRoomId: '', // 대상이 되는 채팅방 없음
                        postTitle: _c.postInfo.title,
                        content: '',
                        type: 'favorite',
                        createdAt: Timestamp.now(),
                      );
                      //관심게시글 등록
                      await _c.clickfavoriteButton(_favoriteModel, _ntfModel);
                    },
                    icon: _c.isFavorite.value
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
                child: CustomFullFilledTextButton('채팅하기', () {
                  Get.to(
                    () => ChatScreenPageFromPost(),
                    arguments: {
                      'postId': _c.postInfo.postId,
                      'uid': _c.postInfo.uid,
                      'userName': _c.postInfo.userName,
                      'mannerLevel': _c.level,
                      'profileUrl': _c.postInfo.profileUrl,
                    },
                  );
                }, appPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 게시물 오른쪽 상단의 아이콘 클릭 시  바텀시트 호출
  openPostBottomSheet() async {
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
            CustomButtomSheet(
              '신고하기',
              appBlackColor,
              () {
                // 다이어로그 끄기
                Get.back();
                // 신고하기 페이지로 이동
                Get.toNamed(
                  '/report',
                  arguments: {
                    'postId': _c.postId,
                    // 신고 받는 사람의 uid
                    'uid': _c.postInfo.uid,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
