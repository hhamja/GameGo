import 'package:mannergamer/utilites/index.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPLASH PAGE'),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
