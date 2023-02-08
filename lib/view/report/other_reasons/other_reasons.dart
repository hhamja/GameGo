import 'package:mannergamer/utilites/index/index.dart';

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
  var postId = Get.arguments['postId']; //이전페이지가 게시글 페이지면? null아님
  var chatRoomId = Get.arguments['chatRoomId']; //이전페이지가 채팅 페이지면? null아님
  var uid = Get.arguments['uid']; //신고 받는 uid
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '신고',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        controller: _scrollController,
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기타 신고 사유',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('신고사유가 앞의 신고항목에 없으신가요?\n원하시는 신고 항목이 없는 경우 신고사유를 입력해주세요.'),
            SizedBox(height: 20),
            TextField(
              cursorColor: cursorColor,
              autocorrect: false,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              maxLength: _maxLength,
              keyboardType: TextInputType.text,
              scrollController: _textScrollController,
              showCursor: true,
              focusNode: FocusNode(canRequestFocus: true),
              controller: _textController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                counterText: '글자수 제한 : (${textValue.length}/${_maxLength})',
                hintText: '신고 사유를 입력해주세요.',
                fillColor: appWhiteColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: CustomFullFilledTextButton(
          '신고사유 제출하기',
          () async {
            final text = _textController.text.trim();
            // 1. 신고사유 입력하지 않은 경우
            if (text == '' || text.isEmpty) {
              Get.snackbar('신고 사유 미입력', '신고 사유를 입력해주세요.');
            }
            // 2. 신고사유 입력한 경우
            else {
              print(_textController.text.trim());
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
        ),
      ),
    );
  }
}
