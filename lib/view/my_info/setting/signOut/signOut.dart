import 'package:gamegoapp/utilites/index/index.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final FeedBackController _c = Get.put(FeedBackController());
  final TextEditingController _textController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final TextStyle _boldText = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '탈퇴하기',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaceData.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppSpaceData.heightSmall),
            Text(
              '${_auth.currentUser!.displayName!}님, 안녕하세요!',
              style: _boldText,
            ),
            Text(
              '$appName와 이별하려고 하시나요?  너무 아쉬워요.',
              style: _boldText,
            ),
            SizedBox(height: 10),
            Text(
              '우리가 이별하면 게시글, 채팅, 매너레벨, 관심 등 모든 계정 정보가 삭제 돼요. 삭제된 계정 정보는 평생 복구할 수 없어요.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppSpaceData.heightLarge),
            Text(
              '${_auth.currentUser!.displayName!}님이 탈퇴하려는 이유가 궁금해요.',
              style: _boldText,
            ),
            SizedBox(height: 20),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: Theme.of(context).textTheme.bodyMedium,
                iconSize: 26,
                buttonPadding: EdgeInsets.fromLTRB(16, 0, 10, 3),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: appBlackColor,
                ),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                dropdownWidth: 300,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                hint: Text(
                  '선택해주세요',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                itemHeight: 60,
                buttonElevation: 0,
                buttonHeight: 50,
                items: leaveAppValue
                    .map(
                      (item) => DropdownMenuItem(
                        // 각 항목별로 해당하는 문구를 배정시킨 if함수 넣기
                        onTap: () {},
                        value: item,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodyMedium,
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
                    cursorColor: cursorColor,
                    onChanged: (value) => setState(
                      () => value,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: '소중한 의견은 $appName 팀에게 전달돼요',
                      hintStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: appGreyColor,
                      ),
                      contentPadding: EdgeInsets.all(16),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(20),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSpaceData.screenPadding),
        child: CustomFullFilledTextButton(
          '$appName와 이별하기',
          () async {
            //0. 아무것도 선택하지 않은 경우
            if (selectedLeaveReason == '선택해주세요' ||
                selectedLeaveReason == null) {
              Get.dialog(
                CustomOneButtonDialog(
                  '탈퇴 이유를 버튼에서 선택해주세요.',
                  '확인',
                  () => Get.back(),
                ),
              );
            } else if (selectedLeaveReason == '기타') {
              // 기타 사유
              final String text = _textController.text.trim();
              if (text.length == 0 || text.isEmpty) {
                // 텍스트를 입력하지 않은 경우
                Get.dialog(
                  CustomOneButtonDialog(
                    '탈퇴 이유를 작성해주세요. 이유를 작성하지 않으면, 탈퇴가 불가능해요.',
                    '확인',
                    () => Get.back(),
                  ),
                );
              } else {
                // 텍스트를 한 글자라도 입력한 경우
                final SignOutFeedBackModel _model = SignOutFeedBackModel(
                  feedBackContent: text,
                  createdAt: Timestamp.now(),
                );

                // 피드백 서버에 저장
                await _c.addFeedBack(_model);
                _textController.clear();
                Get.to(() => SignOutSmsPage());
              }
            } else {
              // 기타사유가 아닌 경우
              final SignOutFeedBackModel _model = SignOutFeedBackModel(
                feedBackContent: selectedLeaveReason.toString(),
                createdAt: Timestamp.now(),
              );
              // 피드백 서버에 저장
              await _c.addFeedBack(_model);
              _textController.clear();
              Get.to(() => SignOutSmsPage());
            }
          },
          appPrimaryColor,
        ),
      ),
    );
  }
}
