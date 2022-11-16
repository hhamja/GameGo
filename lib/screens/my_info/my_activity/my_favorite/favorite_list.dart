import 'package:mannergamer/utilites/index/index.dart';

class MyFavoriteList extends StatefulWidget {
  MyFavoriteList({Key? key}) : super(key: key);

  @override
  State<MyFavoriteList> createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  final FavoriteController _favorite = Get.put(FavoriteController());
  final currentUid = FirebaseAuth.instance.currentUser!.uid; //현재 유저 UId

  @override
  void initState() {
    super.initState();
    print(_favorite.yxxy);
    _favorite.getFavoriteList(currentUid); //현재 유저의 관심 게시글 목록 받기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관심 게시글'),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          //새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
          onRefresh: () async {
            _favorite.favoriteList.clear();
            await _favorite.getFavoriteList(currentUid);
          },
          displacement: 0, //맨 위에 위치시키는 값
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
            itemCount: _favorite.favoriteList.length,
            itemBuilder: (BuildContext context, int index) {
              final _profileUrl = _favorite.favoriteList[index].profileUrl;
              final _userName = _favorite.favoriteList[index].userName;
              final _title = _favorite.favoriteList[index].title;
              final _gamemode = _favorite.favoriteList[index].gamemode;
              final _position = _favorite.favoriteList[index].position;
              final _tear = _favorite.favoriteList[index].tear;
              onTap() {
                Get.toNamed('/postdetail', arguments: {
                  'postId': _favorite.favoriteList[index].postId,
                });
              }

              return CustomPostListTile(
                _profileUrl,
                _userName,
                _title,
                _gamemode,
                _position,
                _tear,
                '', //시간표시 X
                onTap,
              );
            },
          ),
        ),
      ),
    );
  }
}
