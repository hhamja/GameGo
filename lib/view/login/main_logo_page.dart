import 'package:gamegoapp/utilites/index/index.dart';

class MainLogoPage extends StatelessWidget {
  MainLogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appPrimaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Image.asset(
                  'assets/main_logo.png',
                  color: appWhiteColor,
                  width: 150,
                  height: 300,
                ),
              ),
              Container(
                height: 60,
                color: appPrimaryColor,
                child: TextButton(
                  child: Text(
                    '휴대폰으로 시작하기',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.25,
                      color: appWhiteColor,
                    ),
                  ),
                  onPressed: () => Get.to(
                    () => TermsPolicyAgreementPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
