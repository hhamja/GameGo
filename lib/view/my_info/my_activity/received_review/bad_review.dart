import 'package:mannergamer/utilites/index/index.dart';

class BadReviewListPage extends StatefulWidget {
  const BadReviewListPage({Key? key}) : super(key: key);

  @override
  State<BadReviewListPage> createState() => _BadReviewListPageState();
}

class _BadReviewListPageState extends State<BadReviewListPage> {
  final MannerReviewController _review = Get.put(MannerReviewController());

  @override
  void initState() {
    super.initState();
    //내가 받은 매너 후기 리스트 받기
    _review.getBadReviewList(CurrentUser.uid);
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
                'https://firebasestorage.googleapis.com/v0/b/mannergamer-c2546.appspot.com/o/profile%2Fdefault_profile.png?alt=media&token=4a999f41-c0f9-478b-b0ee-d88e5364c689', //기본프로필
                '익명 후기', //비매너평가는 익명으로
                badList.content == '' ? '(내용없음)' : badList.content,
                null,
                null,
                false,
                '',
                () => null,
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
