import 'package:mannergamer/utilites/index/index.dart';

class BadReviewListPage extends StatefulWidget {
  const BadReviewListPage({Key? key}) : super(key: key);

  @override
  State<BadReviewListPage> createState() => _BadReviewListPageState();
}

class _BadReviewListPageState extends State<BadReviewListPage> {
  final String _currentUid = FirebaseAuth.instance.currentUser!.uid;
  final MannerReviewController _review = Get.put(MannerReviewController());

  @override
  void initState() {
    super.initState();
    //내가 받은 매너 후기 리스트 받기
    _review.getBadReviewList(_currentUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 비매너 후기'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final badList = _review.badReviewList[index];
              return CustomTwoLineListTile(
                badList.profileUrl,
                badList.userName,
                badList.content == '' ? '(내용없음)' : badList.content,
                null,
                null,
                '',
                () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
            itemCount: _review.badReviewList.length),
      ),
    );
  }
}
