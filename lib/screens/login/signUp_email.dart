import 'package:mannergamer/utilites/index.dart';

class SignUpEmailPage extends StatelessWidget {
  /* User Auth Controller */
  final UserController _user = Get.find<UserController>();

  /* 이메일 입력 */
  final TextEditingController _emailController = TextEditingController();
  /* 패스워드 입력 */
  final TextEditingController _passwordController = TextEditingController();
  /* 패스워드, 이메일 입력 필드 key */
  final _formKey = GlobalKey<FormState>();

  /* 이메일 Vailidate */
  _vailidatePassword(value) {
    final _password = value!.trim();
    /* 특수문자, 소문자, 대문자 포함 패스워드 조건식 */
    final RegExp _passwordValid = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
    /* 8자 미만 패스워드 */
    if (_password.isEmpty || _password.length < 8) {
      return '8자 이상 입력해주세요';
    }
    /* 특수문자·대·소문자 조건 함수 */
    if (!_passwordValid.hasMatch(_password)) {
      return '특수문자, 문자, 숫자를 각각 포함해주세요';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''), //back 버튼 없애기
        title: Text('회원가입'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /* 이메일 */
              TextFormField(
                validator: (value) {
                  final _email = value!.trim();
                  if (!_email.isEmail) {
                    return '이메일 형식으로 입력해주세요';
                  }
                  return null;
                },
                maxLines: 1,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: 12,
                    height: 0.5,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  labelText: '이메일',
                  hintText: '이메일을 입력해주세요',
                ),
              ),
              SizedBox(height: 20),

              /* 패스워드 */
              TextFormField(
                validator: (value) => _vailidatePassword(value),
                maxLines: 1,
                autocorrect: false,
                controller: _passwordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorStyle: TextStyle(
                    fontSize: 12,
                    height: 0.5,
                  ),
                  border: InputBorder.none,
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력해주세요',
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //check if form data are valid,
                      // your process task ahed if all data are valid
                      _user.signupAndSigninToEmail(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('가입하기', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
