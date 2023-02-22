import 'package:gamegoapp/utilites/index/index.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({Key? key}) : super(key: key);

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
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
          '신고',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(
          AppSpaceData.screenPadding,
        ),
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            subtitle: Text(
              '회원님의 신고는 익명으로 처리됩니다.위급한 상황이라고 생각된다면 즉시 응급 서비스 기관에 연락해주세요.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            height: 13,
          ),
          ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            itemCount: reportPostReason.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 6.5,
                ),
                title: Text(
                  '${reportPostReason[index]}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  if (index == 1) {
                    // 불법 또는 규제 상품 판매
                    Get.toNamed(
                      '/illegal',
                      arguments: {
                        'chatRoomId': chatRoomId ?? null,
                        'postId': postId ?? null,
                        'uid': uid,
                      },
                    );
                  } else if (index == 9) {
                    // 기타 사유
                    Get.toNamed(
                      '/otherReason',
                      arguments: {
                        'chatRoomId': chatRoomId ?? null,
                        'postId': postId ?? null,
                        'uid': uid,
                      },
                    );
                  } else {
                    // 나머지
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
          ),
        ],
      ),
    );
  }
}
