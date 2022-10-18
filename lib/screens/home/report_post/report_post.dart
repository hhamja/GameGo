import 'package:mannergamer/utilites/index/index.dart';

class ReportPostPage extends StatefulWidget {
  const ReportPostPage({Key? key}) : super(key: key);

  @override
  State<ReportPostPage> createState() => _ReportPostPageState();
}

class _ReportPostPageState extends State<ReportPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('신고'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            ListTile(
              title: Text('이 게시물을 신고하는 이유'),
              subtitle: Text(
                  '회원님의 신고는 익명으로 처리됩니다. 누군가 위급한 상황에 있다고 생각된다면 즉시 응급 서비스 기관에 연락해주세요.'),
            ),
            Divider(thickness: 1),
            ListView.separated(
                controller: ScrollController(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${reportPostReason[index]}'),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      if (index == 1) {
                        Get.toNamed('/illegal');
                      } else if (index == 9) {
                        Get.toNamed('/otherReason');
                      } else {
                        Get.dialog(ReportDialog());
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(thickness: 1);
                },
                itemCount: reportPostReason.length),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
