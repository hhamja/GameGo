import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class MySentReviewPage extends StatefulWidget {
  const MySentReviewPage({super.key});

  @override
  State<MySentReviewPage> createState() => _MySentReviewPageState();
}

class _MySentReviewPageState extends State<MySentReviewPage> {
  final MannerReviewController _review = Get.find<MannerReviewController>();
// /* 상대유저 이름, uid, 채팅방 id */
  final String userName = Get.arguments['userName']!;
  final String uid = Get.arguments['uid']!;
  final String chatRoomId = Get.arguments['chatRoomId']!;

  @override
  void initState() {
    super.initState();
    //내가 보낸 매너후기 GEt하기
    _review.getMySentReview(uid, chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    print(_review.myReview);
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 보낸 후기'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  /* 싫어요 */
                  TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        _review.myReview['feeling'] == 'bad'
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
                          '싫어요',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  /* 좋아요 */
                  TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                    child: Column(
                      children: [
                        _review.myReview['feeling'] == 'good'
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
                          '좋아요',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text('$userName 에게 보낸 후기'),
              Text(_review.myReview['content']),
            ],
          ),
        ),
      ),
    );
  }
}
