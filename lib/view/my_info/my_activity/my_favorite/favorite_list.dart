import 'package:gamegoapp/utilites/index/index.dart';

class MyFavoriteList extends StatelessWidget {
  MyFavoriteList({Key? key}) : super(key: key);

  final FavoriteController _c = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '관심 게시글',
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
                '관심 게시글이 없어요.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '하트 버튼을 눌러 관심 게시글에 추가해보세요!',
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
                '정보를 불러올 수 없어요.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '지속적으로 발생한다면 고객센터로 문의해주세요.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        (_) => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaceData.screenPadding,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _c.favoriteList.length,
          itemBuilder: (BuildContext context, int index) {
            final String _profileUrl = _c.favoriteList[index].profileUrl;
            final String _userName = _c.favoriteList[index].userName;
            final String _title = _c.favoriteList[index].title;
            final String _gamemode = _c.favoriteList[index].gamemode;
            final String? _position = _c.favoriteList[index].position;
            final String? _tear = _c.favoriteList[index].tear;

            _onTap() async {
              Get.toNamed(
                '/postdetail',
                arguments: {'postId': _c.favoriteList[index].postId},
              );
            }

            return CustomPostListItem(
              _profileUrl,
              _userName,
              _title,
              _gamemode,
              _position,
              _tear,
              '', //시간표시 X
              _onTap,
            );
          },
        ),
      ),
    );
  }
}
