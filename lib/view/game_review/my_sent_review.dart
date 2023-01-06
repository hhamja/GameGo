import 'package:mannergamer/utilites/index/index.dart';

class MySentReviewPage extends StatefulWidget {
  const MySentReviewPage({super.key});

  @override
  State<MySentReviewPage> createState() => _MySentReviewPageState();
}

class _MySentReviewPageState extends State<MySentReviewPage> {
  final EvaluationController _evaluation = Get.find<EvaluationController>();
  final GameReviewController _review = Get.put(GameReviewController());
  final ScrollController _scrollC = ScrollController();
  /* 상대유저 이름, uid, 채팅방 id */
  final String userName = Get.arguments['userName']!;
  final String uid = Get.arguments['uid']!;
  final String chatRoomId = Get.arguments['chatRoomId']!;

  @override
  void initState() {
    super.initState();
    //1. 내가 보낸 매너 평가 받기
    _evaluation.getMySentEvaluation(uid, chatRoomId);
    //2. 내가 보낸 게임 후기 받기
    _review.getMySentReviewContent(uid, chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 보낸 후기'),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          controller: _scrollC,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* 별로예요 : 최고예요 이모지 */
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        !_evaluation.isGood.value ? '\u{1F629}' : '\u{1F60D}',
                        style: TextStyle(
                          fontSize: 58,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        !_evaluation.isGood.value ? '별로예요' : '최고예요',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                /* 내가 체크한 비매너 : 매너 평가 항목 */
                !_evaluation.isGood.value
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollC,
                        shrinkWrap: true,
                        itemCount: BadEvaluationModel.badList.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: _evaluation.badCheckList[index],
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) => null,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              BadEvaluationModel.badList[index].toString(),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollC,
                        shrinkWrap: true,
                        itemCount: GoodEvaluationModel.goodList.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: _evaluation.goodCheckList[index],
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) => null,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              GoodEvaluationModel.goodList[index].toString(),
                            ),
                          );
                        },
                      ),
                /* 작성한 거래 후기 */
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(10.0) // POINT
                            ),
                  ),
                  child: Text(_review.myReviewContent.value == ''
                      ? '(후기 없음)'
                      : _review.myReviewContent.value),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
