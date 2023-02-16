import 'package:mannergamer/utilites/index/index.dart';

class MySentReviewPage extends StatefulWidget {
  const MySentReviewPage({super.key});

  @override
  State<MySentReviewPage> createState() => _MySentReviewPageState();
}

class _MySentReviewPageState extends State<MySentReviewPage> {
  final EvaluationController _evaluation = Get.put(EvaluationController());
  final SendGameReviewController _review = Get.put(SendGameReviewController());
  final ScrollController _scrollC = ScrollController();
  // 상대유저 이름, uid, 채팅방 id
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
        automaticallyImplyLeading: false,
        title: Text(
          '내가 보낸 후기',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(
            AppSpaceData.screenPadding,
          ),
          controller: _scrollC,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 별로예요 : 최고예요 이모지
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    Text(
                      !_evaluation.isGood.value ? '\u{1F629}' : '\u{1F60D}',
                      style: TextStyle(fontSize: 45.sp),
                    ),
                    Text(
                      !_evaluation.isGood.value ? '별로예요' : '최고예요',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // 내가 체크한 비매너 : 매너 평가 항목
              !_evaluation.isGood.value
                  // 비매너 평가인 경우
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: BadEvaluationModel.badList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: appPrimaryColor,
                          value: _evaluation.badCheckList[index],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) => null,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            BadEvaluationModel.badList[index].toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    )
                  // 매너평가인 경우
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: GoodEvaluationModel.goodList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: appPrimaryColor,
                          value: _evaluation.goodCheckList[index],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) => null,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            GoodEvaluationModel.goodList[index].toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    ),

              // 작성한 거래 후기
              Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(
                  vertical: AppSpaceData.heightSmall,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 15.sp,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.8.sp,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0.sp), // POINT
                  ),
                ),
                child: Text(
                  _review.myReviewContent.value == ''
                      ? '(후기 없음)'
                      : _review.myReviewContent.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
