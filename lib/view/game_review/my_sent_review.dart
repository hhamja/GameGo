import 'package:gamegoapp/utilites/index/index.dart';

import '../../controller/game_review/my_sent_review.dart';

class MySentReviewPage extends StatefulWidget {
  const MySentReviewPage({super.key});

  @override
  State<MySentReviewPage> createState() => _MySentReviewPageState();
}

class _MySentReviewPageState extends State<MySentReviewPage> {
  final MySentGameReviewController _c = Get.put(MySentGameReviewController());
  final ScrollController _scrollC = ScrollController();
  // 상대유저 이름, uid, 채팅방 id
  final String userName = Get.arguments['userName']!;
  final String uid = Get.arguments['uid']!;
  final String chatRoomId = Get.arguments['chatRoomId']!;

  @override
  void initState() {
    super.initState();
    //1. 내가 보낸 매너 평가 받기
    _c.getMySentEvaluation(uid, chatRoomId);
    //2. 내가 보낸 게임 후기 받기
    _c.getMySentReviewContent(uid, chatRoomId);
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
      body: _c.obx(
        onEmpty: Center(
          child: Text(
            '존재하는 매너평가가 없습니다.',
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
        (_) => SingleChildScrollView(
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
                      !_c.isGood.value ? '\u{1F629}' : '\u{1F60D}',
                      style: TextStyle(fontSize: 45.sp),
                    ),
                    Text(
                      !_c.isGood.value ? '별로예요' : '최고예요',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // 내가 체크한 비매너 : 매너 평가 항목
              !_c.isGood.value
                  // 비매너 평가인 경우
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: BadEvaluationModel.badList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: appPrimaryColor,
                          value: _c.badCheckList[index],
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
                          value: _c.goodCheckList[index],
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
                  horizontal: 16,
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
                  _c.myReviewContent.value == ''
                      ? '(후기 없음)'
                      : _c.myReviewContent.value,
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
