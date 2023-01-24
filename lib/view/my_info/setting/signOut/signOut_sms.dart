import 'package:mannergamer/utilites/index/index.dart';

class SignOutSmsPage extends StatefulWidget {
  SignOutSmsPage({Key? key}) : super(key: key);

  @override
  State<SignOutSmsPage> createState() => _SignOutSmsPageState();
}

class _SignOutSmsPageState extends State<SignOutSmsPage> {
  final SmsTimerController _phone = Get.put(SmsTimerController());
  final UserController _user = Get.put(UserController());

  /* 핸드폰 번호 입력 */
  final TextEditingController _phoneController = TextEditingController();
  /* SMS 입력 */
  final TextEditingController _smsController = TextEditingController();

  /* 휴대폰 번호, sms  Key */
  final _formKey = GlobalKey<FormState>();

  /* SMS 전송하기 버튼을 한번이라도 누른 경우 true */
  bool isSendSms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인/회원가입'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /* 전화번호 입력 칸 */
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            final phone = value!.trim();
                            if (phone.length != 13) {
                              return '휴대폰 번호를 전부 입력해주세요.';
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

                    /* SMS 전송 버튼 */
                    Align(
                      heightFactor: 1.3,
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50,
                        width: 120,
                        color: Colors.blue,
                        child: GetBuilder<SmsTimerController>(
                          builder: (controller) => TextButton(
                            onPressed: () async {
                              //1. 처음 sms 보내기를 누른 경우
                              if (!isSendSms &&
                                  _phoneController.text.length == 13) {
                                print(isSendSms);
                                setState(() => isSendSms = true);
                                //1-1. 120초 타이머 시작
                                _phone.StateTimerStart();
                                //1-2. sms 보내기
                                _user
                                    .verifyPhone('+82${_phoneController.text}');
                                print(isSendSms);
                              }
                              //2. 처음 보낸 이후 다시 버튼을 눌러 보내기를 한 경우
                              else if (isSendSms &&
                                  _phoneController.text.length == 13) {
                                //2-1. 120초 타이머 리셋
                                _phone.reset();
                                //2-2. sms 보내기
                                _user
                                    .verifyPhone('+82${_phoneController.text}');
                                print(isSendSms);
                              }
                              null;
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              !isSendSms ? '인증번호 받기' : '재전송(${_phone.count}초)',
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
                  visible: isSendSms,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomTextButton(
          '매너게이머와 이별하기',
          () async {
            // 유저정보 삭제
            await UserController.to.deleteUser(_smsController.text.trim());
            // 앱 초기 회원가입 페이지로 이동
            Get.offAllNamed('/main');
          },
        ),
      ),
    );
  }
}
