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
    _c.getGoodEvaluationList(uid);
  }

  @override
  Widget build(BuildContext context) {
    final _itemHeight = 10.sp;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '받은 매너 평가',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: AppSpaceData.screenPadding,
          ),
          physics: ScrollPhysics(),
          controller: _scrollC,
          child: Column(
            // 해당 유저가 받은 매너 평가
            children: [
              // 친절하고 매너가 좋아요
              GoodEvaluationItem(
                element: _c.kindManner.length,
                title: GoodEvaluationModel.goodList[0],
                verticalHeight: _itemHeight,
              ),
              // 시간 약속을 잘 지켜요
              GoodEvaluationItem(
                element: _c.goodAppointment.length,
                title: GoodEvaluationModel.goodList[1],
                verticalHeight: _itemHeight,
              ),
              // 응답이 빨라요
              GoodEvaluationItem(
                element: _c.fastAnswer.length,
                title: GoodEvaluationModel.goodList[2],
                verticalHeight: _itemHeight,
              ),
              // 맨탈이 강해요
              GoodEvaluationItem(
                element: _c.strongMental.length,
                title: GoodEvaluationModel.goodList[3],
                verticalHeight: _itemHeight,
              ),
              // 게임 실력이 뛰어나요
              GoodEvaluationItem(
                element: _c.goodGameSkill.length,
                title: GoodEvaluationModel.goodList[4],
                verticalHeight: _itemHeight,
              ),
              // 착하고 부드럽게 말해요
              GoodEvaluationItem(
                element: _c.softMannerTalk.length,
                title: GoodEvaluationModel.goodList[5],
                verticalHeight: _itemHeight,
              ),
              // 불편하지 않게 편하게 대해줘요
              GoodEvaluationItem(
                element: _c.goodCommunication.length,
                title: GoodEvaluationModel.goodList[6],
                verticalHeight: _itemHeight,
              ),
              // 게임할 떄 소통을 잘해요
              GoodEvaluationItem(
                element: _c.comfortable.length,
                title: GoodEvaluationModel.goodList[7],
                verticalHeight: _itemHeight,
              ),
              // 게임을 진심으로 열심히 해요
              GoodEvaluationItem(
                element: _c.hardGame.length,
                title: GoodEvaluationModel.goodList[8],
                verticalHeight: _itemHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
