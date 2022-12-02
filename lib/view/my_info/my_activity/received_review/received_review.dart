import 'package:mannergamer/utilites/index/index.dart';

class ReceivedReviewPage extends StatelessWidget {
  const ReceivedReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 후기 3개'),
        centerTitle: true,
      ),
      body: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
          itemBuilder: (BuildContext context, int index) {
            return CustomThreeLineListTile(
              '',
              '김통깡',
              '같이 할 듀오 구합니다.',
              '솔로랭크',
              '정글',
              '아이언',
              '1일 전',
              () {},
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
          itemCount: receivedDuoReviewList.length),
    );
  }
}
