import 'package:mannergamer/utilites/index/index.dart';

class TermsPolicyAgreementPage extends StatefulWidget {
  TermsPolicyAgreementPage({super.key});

  @override
  State<TermsPolicyAgreementPage> createState() =>
      _TermsPolicyAgreementPageState();
}

class _TermsPolicyAgreementPageState extends State<TermsPolicyAgreementPage> {
  bool _isButtonValid = false;
  bool _isConfirmedTerms = false;
  bool _isConfirmedPrivacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: // 로고와 인사말
          Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Image.asset(
              'assets/main_logo.png',
              color: appPrimaryColor,
              width: 30.w,
              height: 30.h,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '안녕하세요',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 3.sp),
                Text(
                  '반가워요 :)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 20.h,
                ),
                // 전체 동의
                CustomCircleCheckBoxTile(
                  _isConfirmedTerms && _isConfirmedPrivacyPolicy,
                  () {
                    setState(() {
                      _isButtonValid = !_isButtonValid;
                      _isConfirmedTerms = _isButtonValid;
                      _isConfirmedPrivacyPolicy = _isButtonValid;
                    });
                  },
                  '전체 동의',
                  null,
                ),
                CustomDivider(),
                // 이용약관 동의
                CustomCircleCheckBoxTile(
                  _isConfirmedTerms,
                  () => setState(() => _isConfirmedTerms = !_isConfirmedTerms),
                  '이용약관 동의(필수)',
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () async => Get.to(TermsDetailPage()),
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 18.sp,
                    ),
                  ),
                ),

                // 개인정보 방침 동의
                CustomCircleCheckBoxTile(
                  _isConfirmedPrivacyPolicy,
                  () => setState(() =>
                      _isConfirmedPrivacyPolicy = !_isConfirmedPrivacyPolicy),
                  '개인정보 수집 및 이용동의(필수)',
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () async =>
                        Get.to(() => PrivacyPolicyDetailPage()),
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
              ],
            ),
          ),
        ],
      ),
      // 핸드폰 페이지로 이동 버튼
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.sp),
        child: CustomFilledTextButton(
          100.w,
          6.h,
          '다음',
          () => _isConfirmedTerms && _isConfirmedPrivacyPolicy
              ? Get.to(
                  () => PhoneAuthPage(),
                )
              : null,
          _isConfirmedTerms && _isConfirmedPrivacyPolicy
              ? appPrimaryColor
              : Colors.grey[350],
        ),
      ),
    );
  }
}
