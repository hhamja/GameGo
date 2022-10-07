import 'package:mannergamer/utilites/index.dart';

class HomePostList extends StatefulWidget {
  HomePostList({Key? key}) : super(key: key);

  @override
  State<HomePostList> createState() => _HomePostListState();
}

class _HomePostListState extends State<HomePostList> {
  /* Post Controller 최초 선언 */
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    print(controller.postList);

    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
        itemCount: controller.postList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.toNamed('/postdetail', arguments: {
                'index': index,
                'uid': controller.postList[index].uid
              });
            },
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                      ),
                      SizedBox(width: 5),
                      Text(
                        /* 제목 */
                        '${controller.postList[index].username}',
                        style: TextStyle(height: 1.2),
                      ),
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
                  Text('${controller.postList[index].title}', maxLines: 1),
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
                  children: [
                    /* 게임모드 · 포지션 · 티어 */
                    Expanded(
                      child: Text(
                          '${controller.postList[index].gamemode} · ${controller.postList[index].position ?? ''} · ${controller.postList[index].tear ?? ''}'),
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     /* 체팅 수 */
                    //     Icon(Icons.chat_bubble_outline, size: 15),
                    //     Text('1'),
                    //     /* 좋아요 수 */
                    //     Icon(Icons.favorite_border_outlined, size: 15),
                    //     Text('1'),
                    //   ],
                    // ),
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
