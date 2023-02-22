import 'package:gamegoapp/utilites/index/index.dart';

class OtherReasonsPage extends StatefulWidget {
  const OtherReasonsPage({Key? key}) : super(key: key);

  @override
  State<OtherReasonsPage> createState() => _OtherReasonsPageState();
}

class _OtherReasonsPageState extends State<OtherReasonsPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _textScrollController = ScrollController();
  final int _maxLength = 300;

  // 이전페이지가 채팅 페이지면? null
  var postId = Get.arguments['postId'];
  // 이전페이지가 게시글 페이지면? null
  var chatRoomId = Get.arguments['chatRoomId'];
  // 신고 받는 uid
  var uid = Get.arguments['uid'];
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '기타사유',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
        controller: _scrollController,
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpaceData.heightSmall),
            Text(
              '신고사유가 앞의 신고항목에 없으신가요?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '원하시는 신고 항목이 없는 경우 신고사유를 입력해주세요.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppSpaceData.heightSmall),
            TextField(
              cursorColor: cursorColor,
              style: Theme.of(context).textTheme.bodyMedium,
              autocorrect: false,
              maxLines: null,
              minLines: 5,
              textAlignVertical: TextAlignVertical.top,
              maxLength: _maxLength,
              keyboardType: TextInputType.text,
              scrollController: _textScrollController,
              showCursor: true,
              focusNode: FocusNode(canRequestFocus: true),
              controller: _textController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(AppSpaceData.screenPadding),
                counterText: '글자수 제한 : (${textValue.length}/${_maxLength})',
                counterStyle: Theme.of(context).textTheme.bodySmall,
                hintText: '신고 사유를 입력해주세요.',
                hintStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: appGreyColor,
                ),
                fillColor: appWhiteColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide:
                      BorderSide(color: appGreyColor, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
              },
            ),
          ],
        ),
      ),
      // 버튼
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSpaceData.screenPadding),
        child: CustomFullFilledTextButton(
          '신고사유 제출하기',
          () async {
            final text = _textController.text.trim();
            // 사유 입력에 대한 조건식
            if (text == '' || text.isEmpty) {
              // 신고사유 입력하지 않은 경우
              Get.dialog(
                CustomOneButtonDialog(
                  '신고 사유를 입력해주세요.',
                  '확인',
                  () => Get.back(),
                ),
              );
            } else {
              // 신고사유 입력한 경우
              Get.dialog(
                ReportDialog(),
                arguments: {
                  'chatRoomId': chatRoomId ?? null,
                  'postId': postId ?? null,
                  'uid': uid,
                  'content': _textController.text.trim(),
                },
              );
            }
          },
          appPrimaryColor,
        ),
      ),
    );
  }
}
