import 'package:mannergamer/utilites/index.dart';

class HomePostList extends StatefulWidget {
  HomePostList({Key? key}) : super(key: key);

  @override
  State<HomePostList> createState() => _HomePostListState();
}

class _HomePostListState extends State<HomePostList> {
  /* Post Controller 최초 선언 */
  final PostController _post = Get.put(PostController());
  /* 프로필 컨트롤러 */
  final ProfileController _profile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    print(_post.postList);
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
        itemCount: _post.postList.length,
        itemBuilder: (BuildContext context, int index) {
          print(_post.postList[index].user!.userName);
          //////////////////////////////////////////////
          return ListTile(
            onTap: () {
              Get.toNamed('/postdetail', arguments: {
                'index': index,
                'postId': _post.postList[index].postId,
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
                            '${_post.postList[index].user!.profileUrl}'),
                      ),
                      SizedBox(width: 5),
                      /* 유저이름 */
                      Text(
                        _post.postList[index].user!.userName,
                        style: TextStyle(height: 1.2),
                      ),
                      /* 날짜 */
                      Expanded(
                        child: Text(
                          '1일 전',
                          style: TextStyle(height: 1.2, fontSize: 10),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  /* 게시글 제목 */
                  Text(_post.postList[index].title, maxLines: 1),
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
                      _post.postList[index].gamemode,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      _post.postList[index].position != null
                          ? ' · ${_post.postList[index].position}'
                          : '',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      _post.postList[index].tear != null
                          ? ' · ${_post.postList[index].tear}'
                          : '',
                      style: TextStyle(fontSize: 12),
                    ),
                    // Text(
                    //   ' · 1일 전',
                    //   style: TextStyle(fontSize: 12),
                    // ),
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
    );
  }
}
