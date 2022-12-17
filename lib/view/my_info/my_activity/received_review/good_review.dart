import 'package:mannergamer/utilites/index/index.dart';

class GoodReviewListPage extends StatefulWidget {
  const GoodReviewListPage({Key? key}) : super(key: key);

  @override
  State<GoodReviewListPage> createState() => _GoodReviewListPageState();
}

class _GoodReviewListPageState extends State<GoodReviewListPage> {
  final MannerReviewController _review = Get.put(MannerReviewController());

  @override
  void initState() {
    super.initState();
    //내가 받은 매너 후기 리스트 받기
    _review.getGoodReviewList(CurrentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 매너 후기'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final goodList = _review.goodReviewList[index];
              return CustomTwoLineListTile(
                goodList.profileUrl,
                goodList.userName,
                goodList.content == '' ? '(내용없음)' : goodList.content,
                null,
                null,
                '',
                () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
            itemCount: _review.goodReviewList.length),
      ),
    );
  }
}
