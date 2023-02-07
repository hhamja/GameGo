import 'package:mannergamer/utilites/index/index.dart';

class UserGameReviewPage extends StatefulWidget {
  const UserGameReviewPage({Key? key}) : super(key: key);

  @override
  State<UserGameReviewPage> createState() => _UserGameReviewPageState();
}

class _UserGameReviewPageState extends State<UserGameReviewPage> {
  final GameReviewController _review = Get.put(GameReviewController());
  final String uid = Get.arguments['uid']; //해당 유저 uid

  @override
  void initState() {
    super.initState();
    // 해당 유저가 받은 게임후기 리스트 받기
    _review.getGameReviewList(uid);
  }

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '받은 게임 후기',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final reviewList = _review.gameReviewList[index];
              return CustomTwoLineListTile(
                reviewList.profileUrl, //후기 보낸 사람의 프로필
                reviewList.userName, //후기 보낸 사람의 이름
                reviewList.content == '' ? '(내용없음)' : reviewList.content,
                null,
                null,
                Jiffy(reviewList.createdAt.toDate()).fromNow(), // '-전'으로 시간표시
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
