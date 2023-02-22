import 'package:gamegoapp/utilites/index/index.dart';

class PhoneAuthPage extends StatefulWidget {
  PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final SmsTimerController _phone = Get.put(SmsTimerController());
  final UserController _user = Get.put(UserController());
  // 핸드폰 번호 입력
  final TextEditingController _phoneController = TextEditingController();
  // SMS 입력
  final TextEditingController _smsController = TextEditingController();
  // 휴대폰 번호, sms  Key
  final _formKey = GlobalKey<FormState>();

  // OTP 처음 받는 경우 : false
  // 두번 째   true로 됨.
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
        leading: Text(''),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpaceData.heightSmall),
              Text(
                '휴대폰 번호',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 5),
              Container(
                width: 100.w,
                height: 65,
                child: TextFormField(
                  cursorColor: cursorColor,
                  style: Theme.of(context).textTheme.bodyLarge,
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
                    contentPadding: EdgeInsets.zero,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    counterText: '',
                    hintText: '숫자만 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      color: appGreyColor,
                    ),
                  ),
                ),
              ),
              // 인증번호 전송 버튼
              GetBuilder<SmsTimerController>(
                builder: (controller) => CustomOutlineTextButton(
                  100.w,
                  45,
                  !isSendSms ? '인증번호 받기' : '재전송(${_phone.count}초)',
                  () async {
                    if (!isSendSms && _phoneController.text.length == 13) {
                      setState(() => isSendSms = true);
                      _phone.StateTimerStart();
                      await _user.verifyPhone('+82${_phoneController.text}');
                    } else if (isSendSms &&
                        _phoneController.text.length == 13) {
                      _phone.reset();
                      await _user.verifyPhone('+82${_phoneController.text}');
                    }
                  },
                  appDeepDarkGrey,
                ),
              ),
              SizedBox(height: AppSpaceData.heightLarge),
              // SMS번호
              Visibility(
                visible: isSendSms,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증번호',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      cursorColor: cursorColor,
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
                      style: Theme.of(context).textTheme.bodyLarge,
                      textInputAction: TextInputAction.done,
                      controller: _smsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        errorStyle: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                          height: 1,
                          color: appRedColor,
                        ),
                        border: InputBorder.none,
                        counterText: '',
                        hintText: '인증번호 6자리를 입력해주세요.',
                        hintStyle: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          color: appGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(AppSpaceData.screenPadding),
        child: Visibility(
          visible: isSendSms,
          child: CustomFullFilledTextButton(
            '시작하기',
            () async {
              //sms입력 ok , 폰번호 13자리 전부 입력 시
              if (_formKey.currentState!.validate() &&
                  _phoneController.text.length == 13) {
                // 유저정보저장
                await _user.signUP(
                  _smsController.text.trim(),
                );
              }
            },
            appPrimaryColor,
          ),
        ),
      ),
    );
  }
}
