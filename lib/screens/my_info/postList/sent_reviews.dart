import 'package:mannergamer/utilites/index/index.dart';

class ViewSentReviews extends StatelessWidget {
  const ViewSentReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 보낸 게임 후기'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: viewSentReviewsBottomSheet,
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('(닉네임)님에게\n따뜻한 후기를 보냈어요'),
            SizedBox(height: 5),
            Text('(닉네임)님과 리그오브레전드 솔로랭크를 같이 했어요.'),
            SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/letter.jpg',
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('(내가 보낸 후기)'),
                        SizedBox(height: 10),
                        Text('· 친절하고 매너가 좋아요.'),
                        SizedBox(height: 10),
                        Text('· 시간 약속을 잘 지켜요.'),
                        SizedBox(height: 10),
                        Text('· 응답이 빨라요.'),
                        SizedBox(height: 10),
                        Text('· 게임 실력이 좋아요.'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 120),
            Container(
              width: double.infinity,
              color: Colors.blue,
              child: TextButton(
                onPressed: () {
                  Get.to(
                    () => ViewReceivedReviews(),
                    transition: Transition.downToUp,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child:
                    Text('받은 게임 후기 보기', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
