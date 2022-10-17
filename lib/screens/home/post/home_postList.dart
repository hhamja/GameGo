import 'package:mannergamer/utilites/index.dart';

class HomePostList extends StatelessWidget {
  HomePostList({Key? key}) : super(key: key);

  /* Post Controller 최초 선언 */
  final PostController _post = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    _post.readPostData(); //이값은 핫리로드 시 데이터가 변하게 함

    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          //새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
          await _post.readPostData();
          // return Futu  re<void>.delayed(const Duration(seconds: 3));
        },
        displacement: 0, //맨 위에 위치시키는 값
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
          padding: EdgeInsets.only(top: 10),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          },
          itemCount: _post.postList.length,
          itemBuilder: (BuildContext context, int index) {
            String time =
                Jiffy(_post.postList[index].createdAt.toDate()).fromNow();
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
                          backgroundImage:
                              NetworkImage(_post.postList[index].profileUrl),
                        ),
                        SizedBox(width: 5),
                        /* 유저이름 */
                        Text(
                          _post.postList[index].userName,
                          style: TextStyle(height: 1.2),
                        ),
                        /* 날짜 */
                        Expanded(
                          child: Text(
                            time,
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
    );
  }
}
