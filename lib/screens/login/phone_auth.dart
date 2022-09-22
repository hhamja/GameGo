import 'package:mannergamer/utilites/index.dart';

class PhoneAuthPage extends StatefulWidget {
  PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final PhoneSMSController _phone = Get.put(PhoneSMSController());
  final UserController _user = Get.put(UserController());
  /* 핸드폰 번호 입력 */
  final TextEditingController _phoneController = TextEditingController();
  /* SMS 입력 */
  final TextEditingController _smsController = TextEditingController();
  /* 휴대폰 번호 TextFormField Key */
  final _phoneFormKey = GlobalKey<FormState>();
  /* SMS TextFormField Key */
  final _smsFormKey = GlobalKey<FormState>();
  /* OTP 처음 받는 경우 : false
  * 두번 째   true로 됨. */
  bool _isSendSms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _smsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(_phone.myDuration.inMinutes.remainder(60));
    final seconds = strDigits(_phone.myDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        leading: Text(''), //back 버튼 없애기
        title: Text('로그인/회원가입'),
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
      body: GetBuilder<PhoneSMSController>(
        builder: (_) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  /* 전화번호 입력 칸 */
                  Form(
                    key: _phoneFormKey,
                    child: Flexible(
                      flex: 1,
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            final phone = value!.trim();
                            if (phone.length != 13) {
                              Get.snackbar('', '휴대폰 번호를 올바르게 입력해주세요.',
                                  snackPosition: SnackPosition.TOP);
                              return;
                            }
                            return null;
                          },
                          maxLength: 13,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskTextInputFormatter(mask: '### #### ####'),
                          ],
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 12,
                              height: 0.3,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: InputBorder.none,
                            counterText: '',
                            labelText: '휴대폰번호',
                            hintText: '― 없이 숫자만 입력해주세요.',
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* SMS 전송 버튼 */
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 50,
                      width: 120,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () async {
                          if (_phoneFormKey.currentState!.validate() &&
                              _phoneController.text.length == 13) {
                            await _user
                                .verifyPhone('+82${_phoneController.text}');
                            _phone.firstClickButton();
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          !_phone.isSendSms
                              ? '인증번호 받기'
                              : '재전송($minutes:$seconds)',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              /* SMS번호 */
              Visibility(
                visible: _phone.isSendSms,
                child: Form(
                  key: _smsFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          final _sms = value!.trim();
                          if (_sms.length != 6) {
                            return '6자리인지 확인해주세요.';
                          } else if (!_sms.isNum) {
                            return '숫자가 아닌 다른 문자가 포함되어있어요.';
                          }
                          return null;
                        },
                        maxLength: 6,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        controller: _smsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          errorStyle: TextStyle(
                            fontSize: 12,
                            height: 0.5,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          hintText: '인증번호 6자리를 입력해주세요.',
                          labelText: '인증번호',
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () async {
                            if (_smsFormKey.currentState!.validate()) {
                              // 유저정보저장
                              await _user.signUP(
                                _smsController.text.trim(),
                              );
                              await Get.to(() => CreateUserNamePage());
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text('시작하기',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: () {}, child: Text('이용약관')),
                          Text('및'),
                          TextButton(onPressed: () {}, child: Text('개인정보취급방침')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              /* 이용약관 및 개인정보 취급방침 */
            ],
          ),
        ),
      ),
    );
  }
}
