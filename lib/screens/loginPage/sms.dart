import 'package:mannergamer/utilites/index.dart';

class SMSPage extends StatefulWidget {
  SMSPage({Key? key}) : super(key: key);

  @override
  State<SMSPage> createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  /* Phone Auth Controller */
  final UserAuthController _userAuth = Get.put(UserAuthController());
  /* InitialScreenCntroller */
  // final InitialScreenCntroller _screen = Get.put(InitialScreenCntroller());
  /* 폰번호 입력 컨트롤러*/
  final _phoneController = TextEditingController();
  /* OTP 번호 입력 컨트롤러 */
  final _otpController = TextEditingController();

  /* OTP 처음 받는 경우 : false
  * 두번 째 부터는 true로 됨. */
  bool _otpBool = false;

  phoneVaildate() async {
    final text = _phoneController.text;
    if (text.trim().length >= 13) {
      await _userAuth.verifyPhone('+82${_phoneController.text}');
      setState(() {
        _otpBool = true;
      });
    }
  }

  /* Life Cycle */
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
          /* 폰번호 입력 칸 */
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '### #### ####',
              ),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '휴대폰 번호(- 없이 숫자만 입력)',
            ),
          ),
          /* otpBool가 true가 아니라면? */
          !_otpBool
              /* orpBool이 false면 실행 */
              ? Column(
                  children: [
                    TextButton(
                      /* 인증문자 받는 버튼, 클릭시 : optBool = true 
                      * 전화번호가 11자리가 채워지지 X ? null : 버튼활성화 */
                      onPressed: phoneVaildate,
                      child: Text('인증 문자 받기'),
                    ),
                    /* 이메일로 계정찾기 */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('전화번호가 변경되었나요?'),
                        TextButton(
                          onPressed: () => Get.to(() => FindAccountPage()),
                          child: Text('이메일로 계정찾기'),
                        )
                      ],
                    ),
                  ],
                )
              /* 인증문자받기 버튼 클릭 시(otpBool == true) 실행 */
              : Column(
                  children: [
                    /* 인증문자다시받기 */
                    TextButton(
                        onPressed: phoneVaildate,
                        child: Text('인증문자 다시 받기(05분 00초)')),
                    /* OTP 입력 란 */
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
                    /* 이용약관 및 개인정보 취급방침 */
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: () {}, child: Text('이용약관')),
                        Text('및'),
                        TextButton(onPressed: () {}, child: Text('개인정보취급방침')),
                      ],
                    ),
                    /* 최종완료버튼 (클릭 -> HomePage로 이동) */
                    TextButton(
                      onPressed: () async {
                        await Get.put(InitialScreenCntroller());
                        /* 유저정보저장 */
                        await _userAuth.signUP(
                          _otpController.text,
                        );
                      },
                      child: Text('동의하고 시작하기'),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
