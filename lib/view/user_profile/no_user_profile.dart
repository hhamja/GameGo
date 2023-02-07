import 'package:mannergamer/utilites/index/index.dart';

class NoUserProfilePage extends StatelessWidget {
  const NoUserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('존재하지 않는 사용자입니다.'),
      ),
    );
  }
}
