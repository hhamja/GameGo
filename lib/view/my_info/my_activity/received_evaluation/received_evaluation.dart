import 'package:gamego/utilites/index/index.dart';

class ReceivedMannerEvaluationPage extends StatefulWidget {
  const ReceivedMannerEvaluationPage({Key? key}) : super(key: key);

  @override
  State<ReceivedMannerEvaluationPage> createState() =>
      _ReceivedMannerEvaluationPageState();
}

class _ReceivedMannerEvaluationPageState
    extends State<ReceivedMannerEvaluationPage> {
  final EvaluationController _c = Get.put(EvaluationController());
  final ScrollController _scrollC = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    //내가 받은 매너 평가 리스트 받기
    _c.getGoodEvaluationList(_auth.currentUser!.uid);
    //내가 바든 비매너 평가 리스트 받기
    _c.getBadEvaluationList(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemHeight = 3.sp;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaceData.screenPadding,
            vertical: 0,
          ),
          physics: ScrollPhysics(),
          controller: _scrollC,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 받은 매너 평가
              Text(
                '받은 매너 평가',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // 친절하고 매너가 좋아요
              GoodEvaluationItem(
                element: _c.kindManner.length,
                title: GoodEvaluationModel.goodList[0],
                verticalHeight: itemHeight,
              ),
              // 시간 약속을 잘 지켜요
              GoodEvaluationItem(
                element: _c.goodAppointment.length,
                title: GoodEvaluationModel.goodList[1],
                verticalHeight: itemHeight,
              ),
              // 응답이 빨라요
              GoodEvaluationItem(
                element: _c.fastAnswer.length,
                title: GoodEvaluationModel.goodList[2],
                verticalHeight: itemHeight,
              ),
              // 맨탈이 강해요
              GoodEvaluationItem(
                element: _c.strongMental.length,
                title: GoodEvaluationModel.goodList[3],
                verticalHeight: itemHeight,
              ),
              // 게임 실력이 뛰어나요
              GoodEvaluationItem(
                element: _c.goodGameSkill.length,
                title: GoodEvaluationModel.goodList[4],
                verticalHeight: itemHeight,
              ),
              // 착하고 부드럽게 말해요
              GoodEvaluationItem(
                element: _c.softMannerTalk.length,
                title: GoodEvaluationModel.goodList[5],
                verticalHeight: itemHeight,
              ),
              // 불편하지 않게 편하게 대해줘요
              GoodEvaluationItem(
                element: _c.goodCommunication.length,
                title: GoodEvaluationModel.goodList[6],
                verticalHeight: itemHeight,
              ),
              // 게임할 떄 소통을 잘해요
              GoodEvaluationItem(
                element: _c.comfortable.length,
                title: GoodEvaluationModel.goodList[7],
                verticalHeight: itemHeight,
              ),
              // 게임을 진심으로 열심히 해요
              GoodEvaluationItem(
                element: _c.hardGame.length,
                title: GoodEvaluationModel.goodList[8],
                verticalHeight: itemHeight,
              ),
              SizedBox(height: AppSpaceData.heightLarge),
              // 내가 받은 비매너 평가
              Text(
                '받은 비매너 평가',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 1.sp,
              ),
              Text(
                '(동일 항목을 2개 이상 받은 경우에만 표시됩니다.)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              // 불친절하고 매너가 나빠요
              BadEvaluationItem(
                element: _c.badManner.length,
                title: BadEvaluationModel.badList[0],
                verticalHeight: itemHeight,
              ),
              // 시간 약속을 안 지켜요
              BadEvaluationItem(
                element: _c.badAppointment.length,
                title: BadEvaluationModel.badList[1],
                verticalHeight: itemHeight,
              ),
              // 응답이 늦어요
              BadEvaluationItem(
                element: _c.slowAnswer.length,
                title: BadEvaluationModel.badList[2],
                verticalHeight: itemHeight,
              ),
              // 맨탈이 약해요
              BadEvaluationItem(
                element: _c.weakMental.length,
                title: BadEvaluationModel.badList[3],
                verticalHeight: itemHeight,
              ),
              // 게임 실력이 아쉬워요
              BadEvaluationItem(
                element: _c.badGameSkill.length,
                title: BadEvaluationModel.badList[4],
                verticalHeight: itemHeight,
              ),
              // 고의적으로 트롤 행위를 해요
              BadEvaluationItem(
                element: _c.troll.length,
                title: BadEvaluationModel.badList[5],
                verticalHeight: itemHeight,
              ),
              // 욕설이나 험악한 말을 해요
              BadEvaluationItem(
                element: _c.abuseWord.length,
                title: BadEvaluationModel.badList[6],
                verticalHeight: itemHeight,
              ),
              // 성적인 발언을 해요
              BadEvaluationItem(
                element: _c.sexualWord.length,
                title: BadEvaluationModel.badList[7],
                verticalHeight: itemHeight,
              ),
              // 반말을 사용해요
              BadEvaluationItem(
                element: _c.shortTalk.length,
                title: BadEvaluationModel.badList[8],
                verticalHeight: itemHeight,
              ),
              // 소통을 안해요
              BadEvaluationItem(
                element: _c.noCommunication.length,
                title: BadEvaluationModel.badList[9],
                verticalHeight: itemHeight,
              ),
              // 불편한 분위기를 만들어요
              BadEvaluationItem(
                element: _c.uncomfortable.length,
                title: BadEvaluationModel.badList[10],
                verticalHeight: itemHeight,
              ),
              // 사적인 만남을 하려고 해요
              BadEvaluationItem(
                element: _c.privateMeeting.length,
                title: BadEvaluationModel.badList[11],
                verticalHeight: itemHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
