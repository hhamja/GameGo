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
              return CustomPostListTile(
                '',
                '김통깡',
                '같이 할 듀오 구합니다.',
                '솔로랭크',
                '정글',
                '아이언',
                '1일 전',
                () {},
              );

              // return ListTile(
              //   minLeadingWidth: 0,
              //   isThreeLine: true,
              //   minVerticalPadding: 15,
              //   onTap: () {},
              //   leading: CircleAvatar(
              //     radius: 20,
              //   ),
              //   title: Padding(
              //     padding: const EdgeInsets.only(bottom: 3),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           '닉네임',
              //           style: TextStyle(fontSize: 15),
              //         ),
              //         Text(
              //           '같이 할 골드 듀오 구합니다.',
              //           style: TextStyle(fontSize: 18),
              //         ),
              //       ],
              //     ),
              //   ),
              //   subtitle: Text(
              //     '솔로랭크 · 정글 · 아이언',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   trailing: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         '1일 전',
              //         style: TextStyle(
              //           fontSize: 12,
              //         ),
              //       ),
              //       Expanded(
              //         child: SizedBox(),
              //       ),
              //     ],
              //   ),
              // );
            },
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
            itemCount: receivedDuoReviewList.length));
  }
}
