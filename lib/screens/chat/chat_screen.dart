import 'package:mannergamer/utilites/index.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('(상대유저이름)'), // 상대유저이름
            Text('20.0세'), //유저 나이 (글씨 작게)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {}, //바텀시트호출
            icon: Icon(Icons.more_vert), //알림끄기, 차단, 신고, 나가기(red), 취소
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
