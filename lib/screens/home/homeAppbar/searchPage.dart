import 'package:mannergamer/utilites/index.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({Key? key}) : super(key: key);

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  /* 검색바 입력 컨트롤러 */
  TextEditingController _textcontroller = TextEditingController();
  /* PostController 선언 */
  PostController _postController = Get.put(PostController());
  /* SearchPageController 선언 */
  SearchPageController _searchController = Get.put(SearchPageController());

  /* 최근 검색한 리스트
  -> 로컬로 저장하던지 아니면 파이어스토어에 데이터 저장하던지 생각하자 */
  List<String> _titleTextList = [];

  /* onSubmitted에 넣을 함수 */
  checkEmptyText1(_) {
    if (_textcontroller.text != '') {
      setState(() {
        _titleTextList.add(_textcontroller.text);
        _textcontroller.clear();
      });
      _postController.postList
          .bindStream(_searchController.getSearch(_textcontroller.text));
      Get.back();
    }
  }

  /* 검색 버튼 onPressed에 넣을 함수 */
  checkEmptyText2() {
    if (_textcontroller.text != '') {
      setState(() {
        _titleTextList.add(_textcontroller.text);
        _textcontroller.clear();
      });
      _postController.postList
          .bindStream(_searchController.getSearch(_textcontroller.text));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        /* 검색 바 */
        title: TextField(
          autofocus: true,
          showCursor: true,
          maxLines: 1,
          cursorColor: Colors.white,
          controller: _textcontroller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: '검색어를 입력해 주세요.',
            border: InputBorder.none,
          ),

          /* 키보드 자체적인 검색 버튼 눌렀을 시 -> 리스트페이지 */
          onSubmitted: checkEmptyText1,
        ),
        /* 검색완료버튼 -> 클릭 시 리스트페이지로 */
        actions: [
          TextButton(
            onPressed: checkEmptyText2,
            child: Text(
              '검색',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('최근 검색어'),
                Expanded(child: SizedBox()),
                /* 클릭 시 최근 검색어 데이터 전부지움 */
                TextButton(
                    onPressed: () {
                      setState(() {
                        _titleTextList.clear();
                      });
                    },
                    child: Text('모두 지우기')),
              ],
            ),
            /* 최근검색한 데이터 보여주는 List */
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
