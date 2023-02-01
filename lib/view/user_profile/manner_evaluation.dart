import 'package:mannergamer/utilites/index/index.dart';

class UserMannerEvaluationPage extends StatefulWidget {
  const UserMannerEvaluationPage({Key? key}) : super(key: key);

  @override
  State<UserMannerEvaluationPage> createState() =>
      _UserMannerEvaluationPageState();
}

class _UserMannerEvaluationPageState extends State<UserMannerEvaluationPage> {
  final EvaluationController _c = Get.put(EvaluationController());
  final ScrollController _scrollC = ScrollController();
  final String uid = Get.arguments['uid'];
  @override
  void initState() {
    super.initState();
    //해당 유저가 받은 매너 평가 리스트 받기
    _c.getGoodEvaluationList(uid);
  }

  @override
  Widget build(BuildContext context) {
    print(uid);

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
            // 해당 유저가 받은 매너 평가
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
              CustomGoodEvaluationItem(
                element: _c.kindManner.length,
                title: GoodEvaluationModel.goodList[0],
              ),
              // 2.'시간 약속을 잘 지켜요.',
              CustomGoodEvaluationItem(
                element: _c.goodAppointment.length,
                title: GoodEvaluationModel.goodList[1],
              ),
              // 3.'응답이 빨라요.',
              CustomGoodEvaluationItem(
                element: _c.fastAnswer.length,
                title: GoodEvaluationModel.goodList[2],
              ),
              // 4.'맨탈이 강해요.',
              CustomGoodEvaluationItem(
                element: _c.strongMental.length,
                title: GoodEvaluationModel.goodList[3],
              ),
              // 5.'게임 실력이 뛰어나요.',
              CustomGoodEvaluationItem(
                element: _c.goodGameSkill.length,
                title: GoodEvaluationModel.goodList[4],
              ),
              // 6.'착하고 부드럽게 말해요.',
              CustomGoodEvaluationItem(
                element: _c.softMannerTalk.length,
                title: GoodEvaluationModel.goodList[5],
              ),
              // 7.'불편하지 않게 편하게 대해줘요.',
              CustomGoodEvaluationItem(
                element: _c.goodCommunication.length,
                title: GoodEvaluationModel.goodList[6],
              ),
              // 8.'게임할 떄 소통을 잘해요.',
              CustomGoodEvaluationItem(
                element: _c.comfortable.length,
                title: GoodEvaluationModel.goodList[7],
              ),
              // 9.'게임을 진심으로 열심히 해요.',
              CustomGoodEvaluationItem(
                element: _c.hardGame.length,
                title: GoodEvaluationModel.goodList[8],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
