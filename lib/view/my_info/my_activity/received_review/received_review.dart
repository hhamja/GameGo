import 'package:gamego/utilites/index/index.dart';

class ReceivedGameReviewPage extends StatefulWidget {
  const ReceivedGameReviewPage({Key? key}) : super(key: key);

  @override
  State<ReceivedGameReviewPage> createState() => _ReceivedGameReviewPageState();
}

class _ReceivedGameReviewPageState extends State<ReceivedGameReviewPage> {
  final ReadGameReviewController _c = Get.put(ReadGameReviewController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    // 내가 받은 게임후기 리스트 받기
    _c.getGameReviewList(_auth.currentUser!.uid);
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
      body: _c.obx(
        onEmpty: Center(
          child: Text(
            '받은 게임 후기가 없습니다.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        onError: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '정보를 불러올 수 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '지속적으로 발생한다면 고객센터로 문의해주세요.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        (_) => ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: AppSpaceData.screenPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              final reviewList = _c.gameReviewList[index];
              return GameReviewItem(
                reviewList.profileUrl,
                reviewList.userName,
                reviewList.content == '' ? '(내용없음)' : reviewList.content,
                null,
                null,
                Jiffy(reviewList.createdAt.toDate()).fromNow(),
              );
            },
            itemCount: _c.gameReviewList.length),
      ),
    );
  }
}
