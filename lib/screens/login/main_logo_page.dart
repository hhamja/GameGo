import 'package:mannergamer/utilites/index.dart';

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
              /* 회원가입과 로그인 통합 */
              Row(
                children: [
                  TextButton(
                    child: Text('이메일로 로그인'), //로그인페이지 -> 거기서 회원가입 연결
                    onPressed: () => Get.to(() => SignInEmailPage()),
                  ),
                  TextButton(
                    child: Text('이메일로 가입'), //로그인페이지 -> 거기서 회원가입 연결
                    onPressed: () => Get.to(() => SignUpEmailPage()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
