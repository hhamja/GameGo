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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('기타 신고 사유'),
              SizedBox(
                height: 10,
              ),
              Text('신고사유가 앞의 신고항목에 없으신가요?'),
              SizedBox(
                height: 10,
              ),
              Text('원하시는 신고 항목이 없는 경우 신고사유를 입력해주세요.'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  minLines: 1,
                  maxLines: null,
                  maxLength: _maxLength,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  scrollController: _textScrollController,
                  showCursor: true,
                  controller: _textController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    counterText: '글자수 제한 : (${textValue.length}/${_maxLength})',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: Colors.grey[300],
                    filled: true,
                    hintText: '신고 사유를 입력해주세요.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      textValue = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '신고사유 제출하기',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
