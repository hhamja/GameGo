import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class SendReviewPage extends StatefulWidget {
  SendReviewPage({super.key});

  @override
  State<SendReviewPage> createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  /* 게시글 정보와 상대유저이름 채팅페이지에서 받기 */
  final String userName = Get.arguments['userName'];
  final String postId = Get.arguments['postId'];
  final String title = Get.arguments['title'];
  final String gamemode = Get.arguments['gamemode'];
  final String? position = Get.arguments['position'];
  final String? tear = Get.arguments['tear'];
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
                        isBad = true;
                        isGood = false;
                      });
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        !isBad
                            ? Icon(
                                CupertinoIcons.hand_thumbsdown,
                                size: 50,
                                color: Colors.black87,
                              )
                            : Icon(
                                CupertinoIcons.hand_thumbsdown_fill,
                                size: 50,
                                color: Colors.black87,
                              ),
                        SizedBox(height: 10),
                        Text(
                          '싫어요',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShowReviewForm = true;
                        isGood = true;
                        isBad = false;
                      });
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        !isGood
                            ? Icon(
                                CupertinoIcons.hand_thumbsup,
                                size: 50,
                                color: Colors.black87,
                              )
                            : Icon(
                                CupertinoIcons.hand_thumbsup_fill,
                                size: 50,
                                color: Colors.black87,
                              ),
                        SizedBox(height: 10),
                        Text(
                          '좋아요',
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
                        controller: _reviewText,
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
          Get.back();
        }),
      ),
    );
  }
}
