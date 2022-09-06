import 'package:mannergamer/utilites/index.dart';

class ReceivedMannerEvaluationPage extends StatelessWidget {
  const ReceivedMannerEvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('받은 매너 평가'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info_outline))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.sentiment_satisfied),
              minLeadingWidth: 0,
              horizontalTitleGap: 5,
              title: Text(
                '받은 매너 칭찬',
                style: TextStyle(height: 1.2),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mannerEvaluationList['goodMannerList'].length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:
                      Text('${mannerEvaluationList['goodMannerList'][index]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people_alt_outlined),
                      SizedBox(width: 5),
                      Text(
                          '${mannerEvaluationList['goodMannerCountList'][index]}'),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.sentiment_satisfied),
              minLeadingWidth: 0,
              horizontalTitleGap: 5,
              title: Text(
                '받은 비매너',
                style: TextStyle(height: 1.2),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mannerEvaluationList['badMannerList'].length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:
                      Text('${mannerEvaluationList['badMannerList'][index]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people_alt_outlined),
                      SizedBox(width: 5),
                      Text(
                          '${mannerEvaluationList['badmannerCountList'][index]}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
