import 'package:mannergamer/utilites/index/index.dart';

class UserGameReviewPage extends StatefulWidget {
  const UserGameReviewPage({Key? key}) : super(key: key);

  @override
  State<UserGameReviewPage> createState() => _UserGameReviewPageState();
}

class _UserGameReviewPageState extends State<UserGameReviewPage> {
  final GameReviewController _review = Get.put(GameReviewController());

  @override
  void initState() {
    super.initState();
    // 내가 받은 게임후기 리스트 받기
    // _review.getBadReviewList(CurrentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 게임 후기'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final reviewList = _review.gameReviewList[index];
              return CustomTwoLineListTile(
                'https://firebasestorage.googleapis.com/v0/b/mannergamer-c2546.appspot.com/o/profile%2Fdefault_profile.png?alt=media&token=4a999f41-c0f9-478b-b0ee-d88e5364c689', //기본프로필
                '익명 후기', //비매너평가는 익명으로
                reviewList.content == '' ? '(내용없음)' : reviewList.content,
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
            itemCount: _review.gameReviewList.length),
      ),
    );
  }
}
