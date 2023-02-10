import 'package:mannergamer/utilites/index/index.dart';

class ReceivedGameReviewPage extends StatefulWidget {
  const ReceivedGameReviewPage({Key? key}) : super(key: key);

  @override
  State<ReceivedGameReviewPage> createState() => _ReceivedGameReviewPageState();
}

class _ReceivedGameReviewPageState extends State<ReceivedGameReviewPage> {
  final GameReviewController _review = Get.put(GameReviewController());

  @override
  void initState() {
    super.initState();
    // 내가 받은 게임후기 리스트 받기
    _review.getGameReviewList(CurrentUser.uid);
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
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: AppSpaceData.screenPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              final reviewList = _review.gameReviewList[index];
              return GameReviewItem(
                reviewList.profileUrl,
                reviewList.userName,
                reviewList.content == '' ? '(내용없음)' : reviewList.content,
                null,
                null,
                Jiffy(reviewList.createdAt.toDate()).fromNow(),
              );
            },
            itemCount: _review.gameReviewList.length),
      ),
    );
  }
}
