import 'package:gamegoapp/utilites/index/index.dart';

class MyPostDetailPage extends StatelessWidget {
  MyPostDetailPage({Key? key}) : super(key: key);

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
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  onTap: null,
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
                            letterSpacing: 0.5,
                            color: mannerLevelColor,
                          ),
                        ),
                      ),
                      Text(
                        '(매너레벨)',
                        style: TextStyle(
                          fontSize: 13,
                          color: appDarkGrey,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSpaceData.heightMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 제목
                      Text(
                        _c.postInfo.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppSpaceData.heightSmall),
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
                    ],
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
  openPostBottomSheet() async {
    return Get.bottomSheet(
      Container(
        margin: EdgeInsets.all(AppSpaceData.screenPadding),
        decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtomSheet(
              '게시글 수정',
              appBlackColor,
              () async {
                Get.back();
                // 나의 게시물 수정 페이지로 이동
                await Get.to(
                  () => EditPostPage(),
                  arguments: {
                    'postId': _c.postId,
                    'maintext': _c.postInfo.maintext,
                    'title': _c.postInfo.title,
                    'gamemode': _c.postInfo.gamemode,
                    'position': _c.postInfo.position,
                    'tear': _c.postInfo.tear,
                  },
                );
              },
            ),
            CustomButtomSheet(
              '삭제',
              appRedColor,
              () async {
                Get.back();
                // 삭제에 대해 재요청하는 다이어로그 띄우기
                await Get.dialog(
                  DeleteDialog(),
                  arguments: {
                    'postId': _c.postId,
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
