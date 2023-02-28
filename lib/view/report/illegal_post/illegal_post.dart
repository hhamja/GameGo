import 'package:gamegoapp/utilites/index/index.dart';

class IllegallyPostedPage extends StatefulWidget {
  const IllegallyPostedPage({Key? key}) : super(key: key);

  @override
  State<IllegallyPostedPage> createState() => _IllegallyPostedPageState();
}

class _IllegallyPostedPageState extends State<IllegallyPostedPage> {
  // 이전페이지가 게시글 페이지면? null아님
  var postId = Get.arguments['postId'];
  // 이전페이지가 채팅 페이지면? null아님
  var chatRoomId = Get.arguments['chatRoomId'];
  // 신고 받는 uid
  var uid = Get.arguments['uid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '불법 또는 규제 상품 판매',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpaceData.screenPadding),
        shrinkWrap: true,
        children: [
          ListView.builder(
            itemCount: illegalProduct.length,
            padding: EdgeInsets.zero,
            controller: ScrollController(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 6.5,
                ),
                title: Text(
                  '${illegalProduct[index]}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  debugPrint(illegalProduct[index].toString());
                  Get.dialog(ReportDialog(), arguments: {
                    'chatRoomId': chatRoomId ?? null,
                    'postId': postId ?? null,
                    'uid': uid,
                    'content': illegalProduct[index].toString(),
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
