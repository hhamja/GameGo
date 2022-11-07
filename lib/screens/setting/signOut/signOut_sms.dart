import 'package:mannergamer/utilites/index/index.dart';

class SignOutSmsPage extends StatelessWidget {
  SignOutSmsPage({Key? key}) : super(key: key);
  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('탈퇴하기'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _smsController,
            maxLength: 6,
            autocorrect: false,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          TextButton(
            onPressed: () async {
              await UserController.to.deleteUser(_smsController.text.trim());
              Get.offAllNamed('/main');
            },
            child: Text('탈퇴하기'),
          ),
        ],
      ),
    );
  }
}
