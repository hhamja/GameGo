import 'package:mannergamer/utilites/index/index.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final FeedBackController _c = Get.put(FeedBackController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();
  final GlobalKey _key = GlobalKey<FormState>(); //기타 선택 시 나타나는 텍스트 필드 key

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
                '${CurrentUser.name}님, 안녕하세요!',
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
                  '우리가 이별하면 게시글, 채팅, 매너온도, 관심 등 모든 계정 정보가 삭제 됩니다. 삭제된 계정 정보는 평생 복구할 수 없어요.'),
              SizedBox(height: 30),
              Text(
                '${CurrentUser.name}님이 탈퇴하려는 이유가 궁금해요.',
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
                  hint: Text(
                    '선택해주세요',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  itemHeight: 40,
                  buttonElevation: 0,
                  buttonHeight: 40,
                  items: leaveAppValue
                      .map(
                        (item) => DropdownMenuItem(
                          onTap: () {}, //각 항목별로 해당하는 문구를 배정시킨 if함수 넣기
                          value: item,
                          child: Text(
                            item,
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
              selectedLeaveReason == '기타'
                  ? TextFormField(
                      onChanged: (value) => setState(() {
                        value;
                      }),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: '소중한 의견은 매너게이머 팀에게 전달돼요',
                        // hintStyle: TextStyle(color: Colors.black),
                        // fillColor: Colors.white,
                        hintStyle: TextStyle(),
                        contentPadding: EdgeInsets.all(15),
                        counterStyle: TextStyle(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
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
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomTextButton(
          '매너게이머와 이별하기',
          () async {
            // 1. 기타사유를 선택한 경우
            if (selectedLeaveReason.toString() == '기타') {
              String text = _textController.text.trim(); //입력한 기타 사유 텍스트
              // 1-1. 텍스트를 입력하지 않은 경우
              if (text.length == 0 || text.isEmpty) {
                Get.snackbar(
                  '탈퇴 이유를 작성해주세요.',
                  '이유를 작성하지 않으면, 탈퇴가 불가능합니다.',
                );
              }
              // 1-2. 텍스트를 한 글자라도 입력한 경우
              else {
                final SignOutFeedBackModel _model = SignOutFeedBackModel(
                  feedBackContent: text,
                  createdAt: Timestamp.now(),
                );
                _c.addFeedBack(_model); //DB에 피드백 저장
                await UserController.to
                    .verifyPhone(_auth.currentUser!.phoneNumber!);
                _textController.clear(); //작성한 텍스트 필드 내용 제거
                Get.to(() => SignOutSmsPage()); //OTP 인증 페이지로 이동
              }
            } else if (selectedLeaveReason.toString() == '선택해주세요') {
              Get.snackbar(
                '이유 선택 안함',
                '탈퇴 이유를 버튼에서 선택해주세요.',
              );
            }
            // 2. 기타사유가 아닌 경우
            else {
              final SignOutFeedBackModel _model = SignOutFeedBackModel(
                feedBackContent: selectedLeaveReason.toString(),
                createdAt: Timestamp.now(),
              );
              _c.addFeedBack(_model); //DB에 피드백 저장
              await UserController.to
                  .verifyPhone(_auth.currentUser!.phoneNumber!);
              _textController.clear(); //작성한 텍스트 필드 내용 제거
              Get.to(() => SignOutSmsPage()); //OTP 인증 페이지로 이동
            }
          },
        ),
      ),
    );
  }
}
