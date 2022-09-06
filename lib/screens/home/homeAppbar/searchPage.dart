import 'package:mannergamer/utilites/index.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({Key? key}) : super(key: key);

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  final TextEditingController _controller = TextEditingController();
  void _clearTextField() {
    _controller.clear();
    setState(() {});
  }

  List<String> _titleTextList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          autofocus: true,
          showCursor: true,
          maxLines: 1,
          cursorColor: Colors.white,
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onPressed: _clearTextField,
                    ),
              border: InputBorder.none),
          onSubmitted: (_) {
            setState(() {
              _titleTextList.add(_controller.text);
              _controller.clear();
            });
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('최근 검색어'),
                Expanded(child: SizedBox()),
                Text('모두 지우기'),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: _titleTextList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${_titleTextList[index]}'),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            _titleTextList.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.close),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
