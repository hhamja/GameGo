import 'package:mannergamer/utilites/index.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  /* 게시물 올린 유저의 uid */
  final String? uid = Get.arguments;

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
              child: Messages(
                uid: uid ?? '', //상대 유저 uid값 전달
              ),
            ),
            NewMessage(
              uid: uid ?? '', //상대 유저 uid값 전달
            ),
          ],
        ),
      ),
    );
  }
}
