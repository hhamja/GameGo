import 'package:mannergamer/utilites/index.dart';

class PhoneLoginPage extends StatefulWidget {
  PhoneLoginPage({Key? key}) : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  bool _otpBool = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입/로그인'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('환영합니다!'),
          Text('휴대폰 번호로 가입해주세요.'),
          Text('휴대폰번호는 안전하게 보관되며 어디에도 공개되지 않아요.'),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            key: _formKey,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '### #### ####',
              ),
            ],
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: '휴대폰 번호(- 없이 숫자만 입력)'),
          ),
          !_otpBool
              ? Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        SupabaseHelper().sendVerifyOTP(
                            phone: '+82${_phoneController.text}');
                        setState(() {
                          _otpBool = true;
                        });
                      },
                      child: Text('인증 문자 받기'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('전화번호가 변경되었나요?'),
                        TextButton(
                          onPressed: () => Get.to(FindAccountPage()),
                          child: Text('이메일로 계정찾기'),
                        )
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    TextButton(
                        onPressed: () async {
                          SupabaseHelper().sendVerifyOTP(
                              phone: '+82${_phoneController.text}');
                        },
                        child: Text('인증문자 다시 받기(05분 00초)')),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          hintText: '인증번호 6자리 입력',
                          helperText: '어떤 경우에도 타인과 공유하지 마세요.'),
                    ),

                    //이용약관 및 개인정보 취급방침
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: () {}, child: Text('이용약관')),
                        Text('및'),
                        TextButton(onPressed: () {}, child: Text('개인정보취급방침')),
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          SupabaseHelper().verifyPhoneNumber(
                              phone: '+82${_phoneController.text}',
                              token: _otpController.text);
                          Get.offAll(CreateUsername());
                        },
                        child: Text('동의하고 시작하기'))
                  ],
                ),
        ],
      ),
    );
  }
}
