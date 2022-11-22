import 'package:mannergamer/utilites/index/index.dart';

class MainLogoPage extends StatelessWidget {
  MainLogoPage({Key? key}) : super(key: key);

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
                child: Text('카카오로 시작하기'),
                onPressed: () {},
              ),
              TextButton(
                child: Text('네이버로 시작하기'),
                onPressed: () {},
              ),
              TextButton(
                child: Text('휴대폰으로 시작하기'),
                onPressed: () {
                  Get.to(() => PhoneAuthPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
