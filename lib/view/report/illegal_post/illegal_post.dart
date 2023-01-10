import 'package:mannergamer/utilites/index/index.dart';

class IllegallyPostedPage extends StatefulWidget {
  const IllegallyPostedPage({Key? key}) : super(key: key);

  @override
  State<IllegallyPostedPage> createState() => _IllegallyPostedPageState();
}

class _IllegallyPostedPageState extends State<IllegallyPostedPage> {
  var postId = Get.arguments['postId']; //이전페이지가 게시글 페이지면? null아님
  var chatRoomId = Get.arguments['chatRoomId']; //이전페이지가 채팅 페이지면? null아님
  var uid = Get.arguments['uid']; //신고 받는 uid

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('신고'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text('불법 또는 규제 상품 판매'),
            contentPadding: EdgeInsets.zero,
            subtitle: Text('해당하는 판매 품목을 아래에서 선택해주세요.'),
          ),
          Divider(thickness: 1),
          ListView.separated(
              padding: EdgeInsets.zero,
              controller: ScrollController(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${illegalProduct[index]}'),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                  onTap: () {
                    print(illegalProduct[index].toString());
                    Get.dialog(ReportDialog(), arguments: {
                      'chatRoomId': chatRoomId ?? null,
                      'postId': postId ?? null,
                      'uid': uid,
                      'content': illegalProduct[index].toString(),
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(thickness: 1);
              },
              itemCount: illegalProduct.length),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
