import 'package:mannergamer/utilites/index/index.dart';

class ViewReceivedReviews extends StatelessWidget {
  const ViewReceivedReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomCloseButton(),
        title: Text(
          '받은 게임 후기',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: receivedReviewsBottomSheet,
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
          ],
        ),
      ),
    );
  }
}
