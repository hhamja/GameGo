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
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('신고'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기타 신고 사유',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text('신고사유가 앞의 신고항목에 없으신가요?\n원하시는 신고 항목이 없는 경우 신고사유를 입력해주세요.'),
              SizedBox(height: 20),
              TextField(
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
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: Colors.grey, style: BorderStyle.solid),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: Colors.grey, style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: Colors.grey, style: BorderStyle.solid),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    textValue = value;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomTextButton(
                '신고사유 제출하기',
                () {
                  Get.dialog(ReportDialog());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
