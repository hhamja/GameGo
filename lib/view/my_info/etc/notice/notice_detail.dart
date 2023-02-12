import 'package:mannergamer/utilites/index/index.dart';

class NoticeDetailPage extends StatefulWidget {
  const NoticeDetailPage({Key? key}) : super(key: key);

  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
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
      body: ListView(
        children: [
          ListTile(
            title: Text('$appName 탄생비화'),
            subtitle: Text('2022.06.22'),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('$appName 출시!'),
          ),
        ],
      ),
    );
  }
}
