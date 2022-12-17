import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class SendReviewPage extends StatefulWidget {
  SendReviewPage({super.key});

  @override
  State<SendReviewPage> createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  final MannerReviewController _review = Get.find<MannerReviewController>();

  /* 상대유저 이름, uid, 채팅방 id */
  final String userName = Get.arguments['userName'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];

  String _feeling = '';
  bool isBad = false;
  bool isGood = false;
  bool isShowReviewForm = false;

  final TextEditingController _reviewText = TextEditingController();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 게시글 정보 */
              // CustomPostInfo(
              //   postId,
              //   title, //제목
              //   gamemode, //게임모드
              //   position, //포지션
              //   tear, //티어
              // ),
              // Divider(thickness: 0.5),
              // Text('$userName님과의 게임이 어떠셨나요?'),

              /* 별로에요  최고에요 이모지 */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShowReviewForm = true;
                        _feeling = 'bad';
                      });
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        _feeling == 'bad'
                            ? Icon(
                                CupertinoIcons.hand_thumbsdown_fill,
                                size: 50,
                                color: Colors.black87,
                              )
                            : Icon(
                                CupertinoIcons.hand_thumbsdown,
                                size: 40,
                                color: Colors.black87,
                              ),
                        SizedBox(height: 10),
                        Text(
                          '별로에요',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShowReviewForm = true;
                        _feeling = 'good';
                      });
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        _feeling == 'good'
                            ? Icon(
                                CupertinoIcons.hand_thumbsup_fill,
                                size: 50,
                                color: Colors.blue,
                              )
                            : Icon(
                                CupertinoIcons.hand_thumbsup,
                                size: 40,
                                color: Colors.black87,
                              ),
                        SizedBox(height: 10),
                        Text(
                          '최고에요',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /* 리뷰 작성 박스 */
              isShowReviewForm
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
              '$userName에게 보낸 후기는\n수정 및 삭제가 불가합니다',
              '취소',
              '보내기',
              () {
                Get.back();
              },
              () async {
                final ReviewModel _reviewModel = ReviewModel(
                  userName: FirebaseAuth.instance.currentUser!.displayName ??
                      '(이름없음)',
                  profileUrl: FirebaseAuth.instance.currentUser!.photoURL ?? '',
                  feeling: _feeling,
                  content: _reviewText.text.trim(),
                  createdAt: Timestamp.now(),
                );
                await _review.addMannerReview(
                  uid,
                  chatRoomId,
                  _reviewModel,
                );
                await _review.checkExistReview(uid, chatRoomId);
                _reviewText.clear();
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
