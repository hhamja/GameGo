import 'package:mannergamer/utilites/index/index.dart';

class SelfAuthenticationPage extends StatefulWidget {
  const SelfAuthenticationPage({Key? key}) : super(key: key);

  @override
  State<SelfAuthenticationPage> createState() => _SelfAuthenticationPageState();
}

class _SelfAuthenticationPageState extends State<SelfAuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('본인인증 정보'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('인증날짜'),
              subtitle: Text('2022.3.6'),
            ),
            ListTile(
              title: Text('휴대폰 번호'),
              subtitle: Text('010-8563-5144'),
            ),
            ListTile(
              title: Text('생년월일'),
              subtitle: Text('19960126'),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 17),
              child: Text(
                '혹시 본인인증 정보가 잘못되었나요?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ));
  }
}
