import 'package:mannergamer/utilites/index.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  /* find -> PostController */
  PostController controller = Get.find<PostController>();
  /* 해당 게시물의 lisview에서의 index값 전달 받음 */
  final index = Get.arguments['index'];
  /* 게시물 Id 값 */
  final postId = Get.arguments['postId'];

  /* 게시물 좋아요 버튼 클릭하면 on/off 되는 bool 값 */
  bool _click = true;

  @override
  Widget build(BuildContext context) {
    print(index);
    print(postId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          /* 외부SNS로 해당 게시물 공유버튼 */
          IconButton(onPressed: () {}, icon: Icon(Icons.ios_share)),
          /* 내게시물 ? openMypostBottomSheet() : openBottomSheet() */
          IconButton(
              onPressed: openMypostBottomSheet, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16),
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.postList[index].profileUrl),
                  ),
                  title: Text(
                    controller.postList[index].userName,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* 유저 매너나이 */
                      // 유저 DB에서 uid로 해당 유저의 매너나이 불러오기
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(controller.postList[index].mannerAge),
                          Icon(Icons.child_care),
                        ],
                      ),
                      Text(
                        '매너나이',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 25, 16, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /* 제목 */
                      Text(
                        '${controller.postList[index].title}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      /* 게임모드, 포지션, 티어 */
                      Row(
                        children: [
                          Text(
                            '${controller.postList[index].gamemode}',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            controller.postList[index].position != null
                                ? ' · ${controller.postList[index].position}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            controller.postList[index].tear != null
                                ? ' · ${controller.postList[index].tear}'
                                : '',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      /* 본문글 */
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          '${controller.postList[index].maintext}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),

                      // SizedBox(height: 30),
                      /* 채팅 · 좋아요 · 조회 수 */
                      // Text('채팅 1 · 관심 1 · 조회 82',
                      //     style: TextStyle(fontSize: 15, color: Colors.black54),
                      //     textAlign: TextAlign.right,
                      //     textWidthBasis: TextWidthBasis.longestLine),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
                /* 신고하기 */
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  onTap: () {
                    Get.toNamed('/reportList');
                  },
                  title: Text('이 게시물 신고하기'),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      /* 하단 좋아요, 채팅하기 버튼 */
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                /* 좋아요 버튼 */
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _click = !_click;
                      });
                    },
                    icon: (_click == true)
                        ? Icon(Icons.favorite_border_outlined)
                        : Icon(
                            Icons.favorite,
                            color: Colors.blue,
                          ),
                  ),
                ),
                /* 채팅하기 버튼 -> ChatPage 이동 */
                Expanded(
                  flex: 5,
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        () => MessagePage(),
                        //게시물 id 값 전달
                        arguments: {'postId': postId},
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('채팅하기', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /** 바텀시트 호출함수 */
  openBottomSheet() {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 180,
        child: Column(
          children: [
            ButtomSheetContent('이 사용자의 글 보지 않기', Colors.blue, () {}),
            ButtomSheetContent('신고', Colors.redAccent, () {}),
            ButtomSheetContent('취소', Colors.blue, () => Get.back()),
          ],
        ),
      ),
    );
  }

  /** 바텀시트 호출함수 */
  openMypostBottomSheet() {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 180,
        child: Column(
          children: [
            ButtomSheetContent('게시물 수정', Colors.blue, () async {
              Get.back();
              await Get.to(
                () => EditPostPage(),
                arguments: index,
              );
            }),
            ButtomSheetContent('삭제', Colors.redAccent, () async {
              Get.back();
              await Get.dialog(DeleteDialog(), arguments: index);
            }),
            ButtomSheetContent('취소', Colors.blue, () => Get.back()),
          ],
        ),
      ),
    );
  }
}
