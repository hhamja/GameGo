import 'package:mannergamer/utilites/index.dart';

class FindAccountPage extends StatelessWidget {
  const FindAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이메일로 계정찾기'),
        centerTitle: true,
      ),
      body: Text('이메일로 계정찾기'),
    );
  }
}
