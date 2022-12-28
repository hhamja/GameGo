import 'package:mannergamer/utilites/index/index.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('탈퇴하기'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${userNameID}님, 안녕하세요!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '매너게이머와 이별하려고 하시나요?  너무 아쉬워요...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                  '우리가 이별하면 게시글, 채팅, 매너온도, 관심 등 모든 계정 정보가 삭제 됩니다. 이에 동의하시면 아래 탈퇴 이유를 선택해주세요.'),
              SizedBox(height: 40),
              Text(
                '${userNameID}님이 탈퇴하려는 이유가 궁금해요.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ), //두꺼운 텍스트로
              SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  iconSize: 30,
                  buttonPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.black,
                  ),
                  buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  dropdownWidth: 230,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  itemHeight: 50,
                  buttonElevation: 0,
                  buttonHeight: 50,
                  hint: Text('선택해주세요.'),
                  items: leaveAppValue
                      .map(
                        (item) => DropdownMenuItem(
                          onTap: () {}, //각 항목별로 해당하는 문구를 배정시킨 if함수 넣기
                          value: item,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.2),
                          ),
                        ),
                      )
                      .toList(),
                  value: selectedLeaveReason,
                  dropdownOverButton: true,
                  onChanged: (value) {
                    setState(() {
                      selectedLeaveReason = value as String;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: '탈퇴하시려는 사유를 적어주세요 :)',
                  // hintStyle: TextStyle(color: Colors.black),
                  // fillColor: Colors.white,
                  hintStyle: TextStyle(),
                  contentPadding: EdgeInsets.all(15),
                  counterText: '소중한 의견은 매너게이머 팀에게 전달돼요',
                  counterStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                minLines: 8,
                maxLines: null,
                showCursor: true,
                keyboardType: TextInputType.text,
                controller: _textController,
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomTextButton(
          '매너게이머와 이별하기',
          () async {
            // await UserController.to.deleteUser();
            // Get.offAllNamed('/main');
            await UserController.to
                .verifyPhone(_auth.currentUser!.phoneNumber!);
            _textController.clear(); //작성한 텍스트 필드 내용 제거
            Get.to(() => SignOutSmsPage()); //OTP 인증 페이지로 이동
          },
        ),
      ),
    );
  }
}
