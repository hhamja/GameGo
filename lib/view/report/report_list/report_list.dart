import 'package:mannergamer/utilites/index/index.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({Key? key}) : super(key: key);

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  var postId = Get.arguments['postId']; //이전페이지가 게시글 페이지면? null아님
  var chatRoomId = Get.arguments['chatRoomId']; //이전페이지가 채팅 페이지면? null아님
  var uid = Get.arguments['uid']; //신고 받는 uid

  @override
  Widget build(BuildContext context) {
    print(uid);
    print(postId);
    print(chatRoomId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '신고',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text('신고하는 이유'),
            contentPadding: EdgeInsets.zero,
            subtitle: Text(
                '회원님의 신고는 익명으로 처리됩니다.위급한 상황이라고 생각된다면 즉시 응급 서비스 기관에 연락해주세요.'),
          ),
          Divider(thickness: 1),
          ListView.separated(
              padding: EdgeInsets.zero,
              controller: ScrollController(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${reportPostReason[index]}'),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                  onTap: () {
                    if (index == 1) {
                      Get.toNamed(
                        '/illegal',
                        arguments: {
                          'chatRoomId': chatRoomId ?? null,
                          'postId': postId ?? null,
                          'uid': uid,
                        },
                      );
                    } else if (index == 9) {
                      Get.toNamed(
                        '/otherReason',
                        arguments: {
                          'chatRoomId': chatRoomId ?? null,
                          'postId': postId ?? null,
                          'uid': uid,
                        },
                      );
                    } else {
                      print(reportPostReason[index].toString());
                      Get.dialog(
                        ReportDialog(),
                        arguments: {
                          'chatRoomId': chatRoomId ?? null,
                          'postId': postId ?? null,
                          'content': reportPostReason[index].toString(),
                          'uid': uid,
                        },
                      );
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return CustomDivider();
              },
              itemCount: reportPostReason.length),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
