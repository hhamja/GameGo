import 'package:mannergamer/utilites/index/index.dart';

class MyFavoriteList extends StatefulWidget {
  MyFavoriteList({Key? key}) : super(key: key);

  @override
  State<MyFavoriteList> createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  final FavoriteController _favorite = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    _favorite.getFavoriteList(); //현재 유저의 관심 게시글 목록 받기
  }

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
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaceData.screenPadding,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _favorite.favoriteList.length,
          itemBuilder: (BuildContext context, int index) {
            final String _profileUrl = _favorite.favoriteList[index].profileUrl;
            final String _userName = _favorite.favoriteList[index].userName;
            final String _title = _favorite.favoriteList[index].title;
            final String _gamemode = _favorite.favoriteList[index].gamemode;
            final String? _position = _favorite.favoriteList[index].position;
            final String? _tear = _favorite.favoriteList[index].tear;

            _onTap() async {
              Get.toNamed(
                '/postdetail',
                arguments: {'postId': _favorite.favoriteList[index].postId},
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
