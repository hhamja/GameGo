import 'package:gamegoapp/utilites/index/index.dart';

class NoUserProfilePage extends StatelessWidget {
  const NoUserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '프로필',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Center(
        child: Text(
          '존재하지 않는 사용자입니다.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
