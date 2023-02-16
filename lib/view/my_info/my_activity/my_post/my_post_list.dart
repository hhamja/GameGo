import 'package:mannergamer/utilites/index/index.dart';

class MyPostListPage extends StatelessWidget {
  MyPostListPage({Key? key}) : super(key: key);
  final MyPostListController _c = Get.put(MyPostListController());

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
      body: _c.obx(
        onEmpty: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '존재하는 게시글이 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "'홈'에서 나의 게시글을 만들어보세요!",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        onError: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '정보를 불러올 수 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '지속적으로 발생한다면 고객센터로 문의해주세요.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        (state) => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaceData.screenPadding,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final String _title = _c.myPostList[index].title;
            final String _gamemode = _c.myPostList[index].gamemode;
            final String? _position = _c.myPostList[index].position;
            final String? _tear = _c.myPostList[index].tear;
            final Timestamp _updatedAt = _c.myPostList[index].updatedAt;
            // 게시글 생성시간 '-전'으로 표시
            final String _time = Jiffy(_updatedAt.toDate()).fromNow();
            _onTap() async {
              await Get.to(
                () => MyPostDetailPage(),
                arguments: {'postId': _c.myPostList[index].postId},
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
          itemCount: _c.myPostList.length,
        ),
      ),
    );
  }
}
