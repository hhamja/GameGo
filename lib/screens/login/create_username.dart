import 'package:mannergamer/utilites/index.dart';

class CreateUserNamePage extends StatelessWidget {
  CreateUserNamePage({Key? key}) : super(key: key);
  /* 닉네임 입력 컨트롤러 */
  final TextEditingController _usernameController = TextEditingController();
  /* User GetX Controller */
  final UserController _userAuth = Get.find<UserController>();

  /* 닉네임  입력 수에 따른 에러 택스트 */
  Text? get _showErrorText {
    final text = _usernameController.text;
    if (text.isEmpty) {
      return Text(
        '닉네임을 입력해주세요!',
        style: TextStyle(color: Colors.red),
      );
    }
    if (text.length < 2) {
      return Text(
        '닉네임은 2자 이상 입력해주세요.',
        style: TextStyle(color: Colors.red),
      );
    }
    return Text('프로필 사진과 닉네임을 입력해주세요.');
  }

  /* 닉네임 입력 수에 따른 bottomButton 색 */
  Color? get _bottomButtonColorChange {
    final text = _usernameController.text;
    if (text.isEmpty || text.length < 2) {
      return Colors.grey;
    }
    return Colors.blue;
  }

  validateButton() async {
    final text = _usernameController.text;
    UserModel userModel = UserModel(
      email: 'kmsaa@naver.com',
      username: text,
      mannerAge: 20,
      createdAt: Timestamp.now(),
    );
    if (!text.isEmpty || text.length >= 2) {
      _userAuth.addNewUser(userModel);
      Get.offAllNamed('/');
    }
    null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('프로필 설정'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: validateButton,
            child: Text(
              '완료',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            child: Icon(Icons.person_pin),
            radius: 80,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요.',
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                counterText: '',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              maxLines: 1,
              showCursor: true,
              controller: _usernameController,
              maxLength: 12,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                // setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'))
              ]),
          SizedBox(
            height: 10,
          ),
          Container(
            child: _showErrorText,
          )
        ],
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: _bottomButtonColorChange,
            child: TextButton(
              onPressed: validateButton,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('완료', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
