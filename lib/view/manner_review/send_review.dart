import 'package:mannergamer/utilites/index/index.dart';

class SendReviewPage extends StatelessWidget {
  SendReviewPage({super.key});
  /* 게시글 정보와 상대유저이름 채팅페이지에서 받기 */
  final String userName = Get.arguments['userName'];
  final String postId = Get.arguments['postId'];
  final String title = Get.arguments['title'];
  final String gamemode = Get.arguments['gamemode'];
  final String? position = Get.arguments['position'];
  final String? tear = Get.arguments['tear'];

  final TextEditingController _reviewText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게임 후기 보내기'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* 게시글 정보 */
            CustomPostInfo(
              postId,
              title, //제목
              gamemode, //게임모드
              position, //포지션
              tear, //티어
            ),
            Divider(thickness: 0.5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$userName님과의 게임이 어떠셨나요?'),
                  /* 별로에요 · 보통이에요 · 최고에요 이모지 */
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('이모지'),
                          Text('별로에요'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('이모지'),
                          Text('보통이에요'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('이모지'),
                          Text('최고에요'),
                        ],
                      ),
                    ],
                  ),
                  Text('$userName과의 게임 후기를 남겨주세요.'),
                  Text('남겨주신 후기는 상대방에게 전달돼요.'),
                  TextFormField(
                    textAlign: TextAlign.left,

                    decoration: InputDecoration(
                      hintText: '후기를 작성해주세요.(선택사항)',
                      hintStyle: TextStyle(),
                      // hintStyle: TextStyle(color: Colors.black),
                      // fillColor: Colors.white,
                      counterText: '',
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
                  Row(
                    children: [
                      CustomButtomSheet(
                        '후기 보내기',
                        Colors.blue,
                        () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
