import 'package:mannergamer/utilites/index/index.dart';

class MyPostListPage extends StatefulWidget {
  const MyPostListPage({Key? key}) : super(key: key);

  @override
  State<MyPostListPage> createState() => _MyPostListPageState();
}

class _MyPostListPageState extends State<MyPostListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('나의 글 내역'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: '듀오 찾는 중',
              ),
              Tab(
                text: '듀오완료',
              ),
              Tab(
                text: '숨김',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //(1) 듀오 찾는 중 tabPage
            ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            right: 0, left: 15, top: 0, bottom: 0),
                        onTap: () => {}, //해당게시물로 이동
                        title: Text('제목', maxLines: 1),
                        trailing: Column(
                          children: [
                            IconButton(
                                onPressed: leftTabOpenBottomSheet,
                                icon: Icon(Icons.more_vert, size: 20),
                                padding: EdgeInsets.zero),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text('솔로랭크 · 1일 전'),
                                Expanded(child: Text('')),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 15),
                                Text('1'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.favorite_border_outlined, size: 15),
                                Text('1'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                onPressed: () {},
                                child: Text('끌어올리기')),
                          ),
                          Expanded(
                            flex: 4,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                onPressed: () {},
                                child: Text('예약중')),
                          ),
                          Expanded(
                            flex: 5,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                onPressed: () {},
                                child: Text('숨김')),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                itemCount: 1),
            //(2)듀오완료 tabPage
            ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            right: 0, left: 15, top: 0, bottom: 0),
                        onTap: () => {}, //해당게시물로 이동
                        title: Text('제목', maxLines: 1),
                        trailing: Column(
                          children: [
                            IconButton(
                                onPressed: centerTabOpenBottomSheet,
                                icon: Icon(Icons.more_vert, size: 20),
                                padding: EdgeInsets.zero),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text('솔로랭크 · 1일 전'),
                                Expanded(child: Text('')),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 15),
                                Text('1'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.favorite_border_outlined, size: 15),
                                Text('1'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              Get.to(
                                () => ViewSentReviews(),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: Text('보낸 후기 보기')),
                      ),
                    ],
                  );
                },
                itemCount: 1),
            //(3)숨김 tabPage
            ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            right: 0, left: 15, top: 0, bottom: 0),
                        onTap: () => {}, //해당게시물로 이동
                        title: Text('제목', maxLines: 1),
                        trailing: Column(
                          children: [
                            IconButton(
                                onPressed: rightTabOpenBottomSheet,
                                icon: Icon(Icons.more_vert, size: 20),
                                padding: EdgeInsets.zero),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text('솔로랭크 · 1일 전'),
                                Expanded(child: Text('')),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 15),
                                Text('1'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.favorite_border_outlined, size: 15),
                                Text('1'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {},
                            child: Text('숨기기 해제')),
                      ),
                    ],
                  );
                },
                itemCount: 1),
          ],
        ),
      ),
    );
  }
}
