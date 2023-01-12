import 'package:mannergamer/utilites/index/index.dart';

class SendReviewPage extends StatefulWidget {
  SendReviewPage({super.key});

  @override
  State<SendReviewPage> createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  final EvaluationController _evaluation = Get.find<EvaluationController>();
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

  List<bool?> goodBoolList = [];
  List<bool?> badBoolList = [];
  @override
  void initState() {
    super.initState();
    //비매너 체크박스 항목의 bool List 만들기
    badBoolList = List.generate(
        BadEvaluationModel.badList.length, (counter) => false,
        growable: false);
    //매너 체크박스 항목의 bool List 만들기
    goodBoolList = List.generate(
        GoodEvaluationModel.goodList.length, (counter) => false,
        growable: false);
  }

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
                      itemCount: BadEvaluationModel.badList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: badBoolList[index],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) =>
                              setState(() => badBoolList[index] = value!),
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              BadEvaluationModel.badList[index].toString()),
                        );
                      },
                    )
                  : SizedBox.shrink(),
              /* 최고예요 선택 시 평가 항목 리스트 */
              _evaluationtype == 'good'
                  ? ListView.builder(
                      controller: _scrollC,
                      shrinkWrap: true,
                      itemCount: GoodEvaluationModel.goodList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: goodBoolList[index],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) => setState(() {
                            goodBoolList[index] = value;
                          }),
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              GoodEvaluationModel.goodList[index].toString()),
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
                /* 1. '최고예요'를 선택한 경우 */
                if (_evaluationtype == 'good') {
                  // 1-1. 매너 평가 인스턴스 생성
                  final GoodEvaluationModel _goodModel = GoodEvaluationModel(
                    idFrom: CurrentUser.uid,
                    idTo: uid,
                    evaluationType: _evaluationtype,
                    kindManner: goodBoolList[0]!,
                    goodAppointment: goodBoolList[1]!,
                    fastAnswer: goodBoolList[2]!,
                    strongMental: goodBoolList[3]!,
                    goodGameSkill: goodBoolList[4]!,
                    softMannerTalk: goodBoolList[5]!,
                    comfortable: goodBoolList[6]!,
                    goodCommunication: goodBoolList[7]!,
                    hardGame: goodBoolList[8]!,
                    createdAt: Timestamp.now(),
                  );
                  // 1-2. notification 인스턴스 생성
                  final NotificationModel _ntfModel = NotificationModel(
                    idFrom: CurrentUser.uid,
                    idTo: uid,
                    type: 'review',
                    postId: postId,
                    content: '',
                    createdAt: Timestamp.now(),
                  );
                  // 1-3. 매너 평가 보내기
                  await _evaluation.addGoodEvaluation(
                      uid, chatRoomId, _goodModel, _ntfModel);

                  /* 1-4. 선택사항인 후기 작성 시 */
                  if ((_reviewText.text.trim() != '') ||
                      _reviewText.text.trim().isNotEmpty) {
                    // 1-4-1. 후기 인스턴스 생성
                    final GameReviewModel _reviewModel = GameReviewModel(
                      idFrom: CurrentUser.uid,
                      idTo: uid,
                      userName:
                          FirebaseAuth.instance.currentUser!.displayName ??
                              '(이름없음)',
                      profileUrl:
                          FirebaseAuth.instance.currentUser!.photoURL ?? '',
                      content: _reviewText.text.trim(),
                      createdAt: Timestamp.now(),
                    );
                    // 1-4-1. 작성한 매너 후기 'review'로 서버에 저장하기
                    await _review.addMannerReview(
                        uid, chatRoomId, _reviewModel);
                    // 1-4-1. 작성한 후기 텍스트 전부 삭제
                    _reviewText.clear();
                    print('매너평가 + 후기작성 O');
                  } else {
                    print('매너평가 + 후기작성 X');
                  }
                }
                /* 2. '별로예요'를 선택한 경우 */
                else if (_evaluationtype == 'bad') {
                  // 2-1. 비매너 평가 인스턴스 생성
                  final BadEvaluationModel _badModel = BadEvaluationModel(
                    idFrom: CurrentUser.uid,
                    idTo: uid,
                    evaluationType: _evaluationtype,
                    badManner: badBoolList[0]!,
                    badAppointment: badBoolList[1]!,
                    slowAnswer: badBoolList[2]!,
                    weakMental: badBoolList[3]!,
                    badGameSkill: badBoolList[4]!,
                    troll: badBoolList[5]!,
                    abuseWord: badBoolList[6]!,
                    sexualWord: badBoolList[7]!,
                    shortTalk: badBoolList[8]!,
                    noCommunication: badBoolList[9]!,
                    uncomfortable: badBoolList[10]!,
                    privateMeeting: badBoolList[11]!,
                    createdAt: Timestamp.now(),
                  );
                  // 2-2. 비매너 평가 보내기
                  await _evaluation.addBadEvaluation(
                      uid, chatRoomId, _badModel);
                  /* 2-3. 선택사항인 후기 작성 시 */
                  if ((_reviewText.text.trim() != '') ||
                      _reviewText.text.trim().isNotEmpty) {
                    // 2-3-1. 신고 인스턴스 생성
                    final ReportModel _report = ReportModel(
                      idFrom: CurrentUser.uid,
                      idTo: uid,
                      reportContent: _reviewText.text.trim(),
                      createdAt: Timestamp.now(),
                    );
                    // 2-3-2. 작성한 비매너 후기 신고하기로 서버에 보내기
                    await _review.addUnMannerReview(_report);
                    // 2-3-3. 작성한 후기 텍스트 전부 삭제
                    _reviewText.clear();
                    print('비매너평가 + 후기작성 O');
                  } else {
                    print('비매너평가 + 후기작성 X');
                  }
                }
                null;

                //보낸 매너후기에 대한 bool값을 채팅화면으로 가기 전 업데이트
                await _evaluation.checkExistEvaluation(uid, chatRoomId);
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
