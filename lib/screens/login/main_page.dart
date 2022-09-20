import 'package:mannergamer/utilites/index.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

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
              /* 회원가입과 로그인 통합 */
              TextButton(
                  child: Text('이메일로 시작하기'),
                  onPressed: () => Get.to(() => SignUpEmailPage())),
            ],
          ),
        ),
      ),
    );
  }
}
