import 'package:mannergamer/utilites/index.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MG'),
              TextButton(
                  child: Text('시작하기'),
                  onPressed: () => Get.to(PhoneLoginPage())),
            ],
          ),
        ),
      ),
    );
  }
}
