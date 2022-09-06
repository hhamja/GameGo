import 'package:mannergamer/utilites/index.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1:1 문의 및 피드백'),
        centerTitle: true,
      ),
      body: Text('1:1 문의 및 피드백 페이지'),
    );
  }
}
