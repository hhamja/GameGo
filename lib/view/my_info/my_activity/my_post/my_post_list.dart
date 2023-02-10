import 'package:mannergamer/utilites/index/index.dart';

class MyPostListPage extends StatelessWidget {
  MyPostListPage({Key? key}) : super(key: key);
  final MyPostListController _controller = Get.put(MyPostListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '나의 글',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          // 새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
          onRefresh: () async {
            await _controller.getMyPostList();
          },
          // 맨 위에 위치시키는 값
          displacement: 0,
          child: ListView.separated(
              // 리스트가 적어도 스크롤 인식 가능
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final _profileUrl = _controller.myPostList[index].profileUrl;
                final _title = _controller.myPostList[index].title;
                final _gamemode = _controller.myPostList[index].gamemode;
                final _position = _controller.myPostList[index].position;
                final _tear = _controller.myPostList[index].tear;
                // 게시글 생성시간 '-전'으로 표시
                String _time =
                    Jiffy(_controller.myPostList[index].updatedAt.toDate())
                        .fromNow();
                _onTap() {
                  Get.toNamed('/postdetail', arguments: {
                    'postId': _controller.myPostList[index].postId,
                  });
                }

                return CustomMyPostListItem(
                  _profileUrl,
                  _title,
                  _gamemode,
                  _position,
                  _tear,
                  _time,
                  _onTap,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return CustomDivider();
              },
              itemCount: _controller.myPostList.length),
        ),
      ),
    );
  }
}
