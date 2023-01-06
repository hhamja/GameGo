import 'package:mannergamer/utilites/index/index.dart';

class SendReviewPage extends StatefulWidget {
  SendReviewPage({super.key});

  @override
  State<SendReviewPage> createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  final MannerEvaluationController _evaluation =
      Get.find<MannerEvaluationController>();
  final GameReviewController _review = Get.put(GameReviewController());
  final ScrollController _scrollC = ScrollController();
  final TextEditingController _reviewText = TextEditingController();

  /* 상대유저 이름, uid, 채팅방 id */
  final String userName = Get.arguments['userName'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String postId = Get.arguments['postId'];
  final String postTitle = Get.arguments['postTitle'];
  String _evaluationtype = '';

  //9개 매너 평가 항목 리스트
  var goodMannerList = [
    '친절하고 매너가 좋아요.',
    '시간 약속을 잘 지켜요.',
    '응답이 빨라요.',
    '맨탈이 강해요.',
    '게임 실력이 뛰어나요.',
    '불편하지 않게 편하게 대해줘요.',
    '착하고 부드럽게 말해요.',
    '게임할 떄 소통을 잘해요.',
    '게임을 진심으로 열심히 해요.'
  ];

  //12개 비매너 평가 항목 리스트
  var badMannerList = [
    '불친절하고 매너가 나빠요.',
    '시간 약속을 안 지켜요.',
    '응답이 늦어요.',
    '맨탈이 약해요.',
    '게임 실력이 아쉬워요.',
    '고의적으로 트롤 행위를 해요.',
    '욕설이나 험악한 말을 해요',
    '성적인 발언을 해요.',
    '반말을 사용해요',
    '소통을 안해요.',
    '불편한 분위기를 만들어요.',
    '사적인 만남을 하려고 해요.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게임 후기 보내기'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          controller: _scrollC,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 별로예요, 최고예요 이모지 */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /* 별로예요 이모지 */
                  TextButton(
                    onPressed: () => setState(
                      () => _evaluationtype = 'bad',
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: _evaluationtype == 'bad'
                        ? Column(
                            children: [
                              Text(
                                '\u{1F629}',
                                style: TextStyle(
                                  fontSize: 58.5,
                                ),
                              ),
                              Text(
                                '별로예요',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey, BlendMode.color),
                                  child: Text(
                                    '\u{1F629}',
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '별로예요',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                  ),
                  /* 최고예요 이모지 */
                  TextButton(
                    onPressed: () => setState(
                      () => _evaluationtype = 'good',
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: _evaluationtype == 'good'
                        ? Column(
                            children: [
                              Text(
                                '\u{1F60D}',
                                style: TextStyle(
                                  fontSize: 58.5,
                                ),
                              ),
                              Text(
                                '최고예요',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey, BlendMode.color),
                                  child: Text(
                                    '\u{1F60D}',
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '최고예요',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              /* 별로예요 선택 시 평가 항목 리스트 */
              _evaluationtype == 'bad'
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: badMannerList.length,
                      itemBuilder: (context, index) {
                        List<bool?> isCheckList = List<bool?>.generate(
                            badMannerList.length, (x) => x == false,
                            growable: false); //항목 개수많은 false 리스트 생성
                        return CheckboxListTile(
                          value: isCheckList[index],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) =>
                              setState(() => isCheckList[index] = value),
                          contentPadding: EdgeInsets.zero,
                          title: Text(badMannerList[index].toString()),
                        );
                      },
                    )
                  : SizedBox.shrink(),
              /* 최고예요 선택 시 평가 항목 리스트 */
              _evaluationtype == 'good'
                  ? ListView.builder(
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: goodMannerList.length,
                      itemBuilder: (context, index) {
                        List<bool?> isCheckList = List<bool?>.generate(
                            goodMannerList.length, (x) => x == false,
                            growable: false); //항목 개수많은 false 리스트 생성
                        return CheckboxListTile(
                          value: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) =>
                              setState(() => isCheckList[index] = value),
                          contentPadding: EdgeInsets.zero,
                          title: Text(goodMannerList[index].toString()),
                        );
                      },
                    )
                  : SizedBox.shrink(),

              /* 후기 작성 박스 */
              _evaluationtype != ''
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: '게임 후기를 작성해주세요.(선택사항)',
                          // hintStyle: TextStyle(color: Colors.black),
                          // fillColor: Colors.white,
                          hintStyle: TextStyle(),
                          contentPadding: EdgeInsets.all(15),
                          counterText: '남겨주신 후기는 상대방에게 전달돼요.',
                          counterStyle: TextStyle(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        minLines: 8,
                        maxLines: null,
                        showCursor: true,
                        keyboardType: TextInputType.text,
                        controller: _reviewText,
                        textInputAction: TextInputAction.done,
                        textAlignVertical: TextAlignVertical.center,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        // onChanged: (value) {
                        //   // setState(() {});
                        // },
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomTextButton('후기 보내기', () {
          Get.dialog(
            CustomSmallDialog(
              '"$userName"에게 한번 보낸 후기는\n수정 및 삭제가 불가합니다',
              '취소',
              '보내기',
              () => Get.back(),
              () async {
                /* '최고예요'를 선택한 경우 */
                if (_evaluationtype == 'good') {
                  // 1. 매너 평가 인스턴스 생성
                  final GoodEvaluationModel _goodModel = GoodEvaluationModel(
                    idFrom: uid,
                    idTo: CurrentUser.uid,
                    evaluationType: _evaluationtype,
                    kindManner: false,
                    goodAppointment: false,
                    fastAnswer: false,
                    strongMental: false,
                    goodGameSkill: false,
                    softMannerTalk: false,
                    comfortable: false,
                    goodCommunication: false,
                    hardGame: false,
                    createdAt: Timestamp.now(),
                  );
                  // 2. notification 인스턴스 생성
                  final NotificationModel _ntfModel = NotificationModel(
                    idTo: uid,
                    idFrom: CurrentUser.uid,
                    userName: FirebaseAuth.instance.currentUser!.displayName ??
                        '(이름없음)',
                    type: 'review',
                    postId: postId,
                    postTitle: postTitle,
                    createdAt: Timestamp.now(),
                  );
                  // 3. 매너 평가 보내기
                  await _evaluation.addGoodEvaluation(
                      uid, chatRoomId, _goodModel, _ntfModel);
                } /* '별로예요'를 선택한 경우 */
                else if (_evaluationtype == 'bad') {
                  // 1. 비매너 평가 인스턴스 생성
                  final BadEvaluationModel _badModel = BadEvaluationModel(
                    idFrom: uid,
                    idTo: CurrentUser.uid,
                    evaluationType: _evaluationtype,
                    badManner: false,
                    badAppointment: false,
                    slowAnswer: false,
                    weakMental: false,
                    badGameSkill: false,
                    troll: false,
                    abuseWord: false,
                    sexualWord: false,
                    shortTalk: false,
                    noCommunication: false,
                    uncomfortable: false,
                    privateMeeting: false,
                    createdAt: Timestamp.now(),
                  );
                  // 2. 비매너 평가 보내기
                  await _evaluation.addBadEvaluation(
                      uid, chatRoomId, _badModel);
                }
                null;

                /* 선택사항인 리뷰 작성 시 */
                if ((_reviewText.text.trim() != '') ||
                    _reviewText.text.trim().isNotEmpty) {
                  // 1. 리뷰 인스턴스 생성
                  final GameReviewModel _reviewModel = GameReviewModel(
                    idTo: uid,
                    idFrom: CurrentUser.uid,
                    userName: FirebaseAuth.instance.currentUser!.displayName ??
                        '(이름없음)',
                    profileUrl:
                        FirebaseAuth.instance.currentUser!.photoURL ?? '',
                    content: _reviewText.text.trim(),
                    createdAt: Timestamp.now(),
                  );
                  // 2. 작성한 후기 파이어스토어에 보내기
                  await _review.addMannerReview(uid, chatRoomId, _reviewModel);
                  // 3. 작성한 리뷰 텍스트 전부 삭제
                  _reviewText.clear();
                }
                //보낸 매너후기에 대한 bool값을 채팅화면으로 가기 전 업데이트
                await _evaluation.checkExistReview(uid, chatRoomId);
                Get.back();
                Get.back();
              },
              2,
              3,
            ),
          );
        }),
      ),
    );
  }
}
