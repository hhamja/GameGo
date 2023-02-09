import 'package:mannergamer/utilites/index/index.dart';

class UserGameReviewPage extends StatefulWidget {
  const UserGameReviewPage({Key? key}) : super(key: key);

  @override
  State<UserGameReviewPage> createState() => _UserGameReviewPageState();
}

class _UserGameReviewPageState extends State<UserGameReviewPage> {
  final GameReviewController _review = Get.put(GameReviewController());
  final String uid = Get.arguments['uid'];

  @override
  void initState() {
    super.initState();
    _review.getGameReviewList(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '받은 게임 후기',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(
            AppSpaceData.screenPadding,
          ),
          itemBuilder: (BuildContext context, int index) {
            final reviewList = _review.gameReviewList[index];
            return GameReviewItem(
              // 후기 보낸 사람의 프로필
              reviewList.profileUrl,
              // 후기 보낸 사람의 이름
              reviewList.userName,
              reviewList.content == '' ? '(내용없음)' : reviewList.content,
              null,
              null,
              // '-전'으로 시간표시
              Jiffy(reviewList.createdAt.toDate()).fromNow(),
              () => null,
            );
          },
          itemCount: _review.gameReviewList.length,
        ),
      ),
    );
  }
}
