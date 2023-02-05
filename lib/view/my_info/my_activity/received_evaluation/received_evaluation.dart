import 'package:mannergamer/utilites/index/index.dart';

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
  @override
  void initState() {
    super.initState();
    //내가 받은 매너 평가 리스트 받기
    _c.getGoodEvaluationList(CurrentUser.uid);
    //내가 바든 비매너 평가 리스트 받기
    _c.getBadEvaluationList(CurrentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 매너 평가'),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          physics: ScrollPhysics(),
          controller: _scrollC,
          child: Column(
            // 받은 매너 평가
            children: [
              ListTile(
                minLeadingWidth: 0,
                title: Text(
                  '받은 매너 평가',
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 1.'친절하고 매너가 좋아요.'
              GoodEvaluationItem(
                element: _c.kindManner.length,
                title: GoodEvaluationModel.goodList[0],
              ),
              // 2.'시간 약속을 잘 지켜요.',
              GoodEvaluationItem(
                element: _c.goodAppointment.length,
                title: GoodEvaluationModel.goodList[1],
              ),
              // 3.'응답이 빨라요.',
              GoodEvaluationItem(
                element: _c.fastAnswer.length,
                title: GoodEvaluationModel.goodList[2],
              ),
              // 4.'맨탈이 강해요.',
              GoodEvaluationItem(
                element: _c.strongMental.length,
                title: GoodEvaluationModel.goodList[3],
              ),
              // 5.'게임 실력이 뛰어나요.',
              GoodEvaluationItem(
                element: _c.goodGameSkill.length,
                title: GoodEvaluationModel.goodList[4],
              ),
              // 6.'착하고 부드럽게 말해요.',
              GoodEvaluationItem(
                element: _c.softMannerTalk.length,
                title: GoodEvaluationModel.goodList[5],
              ),
              // 7.'불편하지 않게 편하게 대해줘요.',
              GoodEvaluationItem(
                element: _c.goodCommunication.length,
                title: GoodEvaluationModel.goodList[6],
              ),
              // 8.'게임할 떄 소통을 잘해요.',
              GoodEvaluationItem(
                element: _c.comfortable.length,
                title: GoodEvaluationModel.goodList[7],
              ),
              // 9.'게임을 진심으로 열심히 해요.',
              GoodEvaluationItem(
                element: _c.hardGame.length,
                title: GoodEvaluationModel.goodList[8],
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
              ),
              // 내가 받은 비매너 평가
              ListTile(
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                title: Text(
                  '받은 비매너 평가',
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text('동일 항목을 2개 이상 받은 경우에만 표시됩니다.'),
                ),
              ),

              // 1.'불친절하고 매너가 나빠요.',
              BadEvaluationItem(
                element: _c.badManner.length,
                title: BadEvaluationModel.badList[0],
              ),
              // 2.'시간 약속을 안 지켜요.',
              BadEvaluationItem(
                element: _c.badAppointment.length,
                title: BadEvaluationModel.badList[1],
              ),
              // 3.'응답이 늦어요.',
              BadEvaluationItem(
                element: _c.slowAnswer.length,
                title: BadEvaluationModel.badList[2],
              ),
              // 4.'맨탈이 약해요.',
              BadEvaluationItem(
                element: _c.weakMental.length,
                title: BadEvaluationModel.badList[3],
              ),
              // 5.'게임 실력이 아쉬워요.',
              BadEvaluationItem(
                element: _c.badGameSkill.length,
                title: BadEvaluationModel.badList[4],
              ),
              // 6.'고의적으로 트롤 행위를 해요.',
              BadEvaluationItem(
                element: _c.troll.length,
                title: BadEvaluationModel.badList[5],
              ),
              // 7.'욕설이나 험악한 말을 해요',
              BadEvaluationItem(
                element: _c.abuseWord.length,
                title: BadEvaluationModel.badList[6],
              ),
              // 8.'성적인 발언을 해요.',
              BadEvaluationItem(
                element: _c.sexualWord.length,
                title: BadEvaluationModel.badList[7],
              ),
              // 9.'반말을 사용해요',
              BadEvaluationItem(
                element: _c.shortTalk.length,
                title: BadEvaluationModel.badList[8],
              ),
              // 10.'소통을 안해요.',
              BadEvaluationItem(
                element: _c.noCommunication.length,
                title: BadEvaluationModel.badList[9],
              ),
              // 11.'불편한 분위기를 만들어요.',
              BadEvaluationItem(
                element: _c.uncomfortable.length,
                title: BadEvaluationModel.badList[10],
              ),
              // 12.'사적인 만남을 하려고 해요.',
              BadEvaluationItem(
                element: _c.privateMeeting.length,
                title: BadEvaluationModel.badList[11],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
