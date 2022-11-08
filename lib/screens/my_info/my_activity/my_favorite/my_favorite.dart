import 'package:mannergamer/utilites/index/index.dart';

class MyFavoriteList extends StatefulWidget {
  MyFavoriteList({Key? key}) : super(key: key);

  @override
  State<MyFavoriteList> createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  final FavoriteController _favorite = Get.put(FavoriteController());
  final currentUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _favorite.getFavoriteList(currentUid);
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
          onRefresh: () async {},
          displacement: 0, //맨 위에 위치시키는 값
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
            padding: EdgeInsets.only(top: 10),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1,
              );
            },
            itemCount: _favorite.favoriteList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.toNamed('/postdetail', arguments: {
                    'index': index,
                  });
                },
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          /* 프로필 */
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                                _favorite.favoriteList[index].profileUrl),
                          ),
                          SizedBox(width: 5),
                          /* 유저이름 */
                          Text(
                            _favorite.favoriteList[index].userName,
                            style: TextStyle(height: 1.2),
                          ),
                          /* 날짜 */
                        ],
                      ),
                      SizedBox(height: 10),
                      /* 게시글 제목 */
                      Text(_favorite.favoriteList[index].title, maxLines: 1),
                    ],
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: double.minPositive,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* 게임모드 · 포지션 · 티어 */
                        Text(
                          _favorite.favoriteList[index].gamemode,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          _favorite.favoriteList[index].position != null
                              ? ' · ${_favorite.favoriteList[index].position}'
                              : '',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          _favorite.favoriteList[index].tear != null
                              ? ' · ${_favorite.favoriteList[index].tear}'
                              : '',
                          style: TextStyle(fontSize: 12),
                        ),
                        // Expanded(child: SizedBox()),
                        // /* 체팅 수 */
                        // Icon(Icons.chat_bubble_outline, size: 15),
                        // Text('1'),
                        // /* 좋아요 수 */
                        // Icon(Icons.favorite_border_outlined, size: 15),
                        // Text('1'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
