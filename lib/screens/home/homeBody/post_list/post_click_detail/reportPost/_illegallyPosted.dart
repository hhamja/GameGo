import 'package:mannergamer/utilites/index.dart';

class IllegallyPostedPage extends StatefulWidget {
  const IllegallyPostedPage({Key? key}) : super(key: key);

  @override
  State<IllegallyPostedPage> createState() => _IllegallyPostedPageState();
}

class _IllegallyPostedPageState extends State<IllegallyPostedPage> {
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
            ),
            Divider(thickness: 1),
            ListView.separated(
                controller: ScrollController(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${illegalProduct[index]}'),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Get.dialog(ReportDialog());
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
      ),
    );
  }
}
