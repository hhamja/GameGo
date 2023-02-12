import 'package:mannergamer/utilites/index/index.dart';

class AccountManagementPage extends StatelessWidget {
  const AccountManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '계정/정보 관리',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('계정정보'),
          ),
          ListTile(
            title: Text('이메일'),
            trailing: TextButton(
              onPressed: () {
                Get.to(() => EmailEnrollPage());
              },
              child: Text(
                '등록',
                style: TextStyle(),
              ),
              style: TextButton.styleFrom(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          ListTile(
            title: Text('휴대폰 번호'),
            subtitle: Text('010-1234-5678'),
            trailing: TextButton(
              onPressed: () {
                Get.to(() => PhoneNumberEditPage());
              },
              child: Text('변경'),
              style: TextButton.styleFrom(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          ListTile(
            title: Text('$appName 가입일'),
            subtitle: Text('2022.6.25'),
            trailing: TextButton(
              onPressed: () {
                Get.to(() => SelfAuthenticationPage());
              },
              child: Text('확인'),
              style: TextButton.styleFrom(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
