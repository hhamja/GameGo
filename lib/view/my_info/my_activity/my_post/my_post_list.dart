import 'package:mannergamer/utilites/index/index.dart';

class MyPostListPage extends StatelessWidget {
  MyPostListPage({Key? key}) : super(key: key);
  final MyPostListController _controller = Get.put(MyPostListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '나의 글',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaceData.screenPadding,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final String _title = _controller.myPostList[index].title;
            final String _gamemode = _controller.myPostList[index].gamemode;
            final String? _position = _controller.myPostList[index].position;
            final String? _tear = _controller.myPostList[index].tear;
            final Timestamp _updatedAt =
                _controller.myPostList[index].updatedAt;
            // 게시글 생성시간 '-전'으로 표시
            final String _time = Jiffy(_updatedAt.toDate()).fromNow();
            _onTap() {
              Get.toNamed(
                '/postdetail',
                arguments: {'postId': _controller.myPostList[index].postId},
              );
            }

            return CustomMyPostListItem(
              _title,
              _gamemode,
              _position,
              _tear,
              _time,
              _onTap,
            );
          },
          itemCount: _controller.myPostList.length,
        ),
      ),
    );
  }
}
