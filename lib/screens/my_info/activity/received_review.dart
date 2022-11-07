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
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minLeadingWidth: 0,
                isThreeLine: true,
                minVerticalPadding: 15,
                leading: CircleAvatar(),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('닉네임'),
                    SizedBox(height: 3),
                    Text(
                      '솔로랭크  ·  1개월 전',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
                subtitle: Text('${receivedDuoReviewList[index]}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 1);
            },
            itemCount: receivedDuoReviewList.length));
  }
}
