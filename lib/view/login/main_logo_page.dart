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
              GestureDetector(
                onTap: () => Get.to(() => TermsPolicyAgreementPage()),
                child: Container(
                  child: Image.asset(
                    'assets/google.png',
                    width: 60,
                    height: 60,
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
