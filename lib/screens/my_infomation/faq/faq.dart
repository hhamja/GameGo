import 'package:mannergamer/utilites/index/index.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        centerTitle: true,
      ),
      body: Text('FAQ 페이지'),
    );
  }
}
