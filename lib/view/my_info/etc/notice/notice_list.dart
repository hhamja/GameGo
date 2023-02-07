import 'package:mannergamer/utilites/index/index.dart';

class AppNoticeListPage extends StatefulWidget {
  const AppNoticeListPage({Key? key}) : super(key: key);

  @override
  State<AppNoticeListPage> createState() => _AppNoticeListPageState();
}

class _AppNoticeListPageState extends State<AppNoticeListPage> {
  Map noticeListData = {
    'noticeTitleList': ['매너게이머 탄생비화', '이제 채팅으로 게임친구를 찾으세요'],
    'noticeDateList': ['2022.06.22', '2022.06.23'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '공지사항',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        reverse: true,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(noticeListData['noticeTitleList'][index]),
            subtitle: Text(noticeListData['noticeDateList'][index]),
            onTap: () {
              Get.to(
                () => NoticeDetailPage(),
              );
            },
          );
        },
        itemCount: noticeListData.length,
      ),
    );
  }
}
