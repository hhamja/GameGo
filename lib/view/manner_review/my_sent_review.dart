import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class MySentReviewPage extends StatefulWidget {
  const MySentReviewPage({super.key});

  @override
  State<MySentReviewPage> createState() => _MySentReviewPageState();
}

class _MySentReviewPageState extends State<MySentReviewPage> {
  final MannerReviewController _review = Get.find<MannerReviewController>();
  /* 상대유저 이름, uid, 채팅방 id */
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: _review.myReview['feeling'] == 'good'
                    ?
                    /* 최고에요 */
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.hand_thumbsup_fill,
                            size: 180,
                            color: Colors.blue[800],
                          ),
                        ],
                      )
                    : /* 별로에요 */
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.hand_thumbsdown_fill,
                            size: 180,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
              ),
              Text(
                'To. $userName',
              ),
              Divider(
                thickness: 0.5,
                color: Colors.black,
                height: 20,
              ),
              Text(
                _review.myReview['content'] == ''
                    ? '(내용없음)'
                    : _review.myReview['content'],
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
