import 'package:mannergamer/utilites/index/index.dart';

class EditPostPage extends StatefulWidget {
  EditPostPage({Key? key}) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  /* find -> PostController (∵ updatePost()) */
  PostController _postController = Get.find<PostController>();
  /* Put -> Edit DropDownBTController */
  EditDropDownController _editDropDownController =
      Get.put(EditDropDownController());

  final postId = Get.arguments['postId']; //게시글 ID
  final maintext = Get.arguments['maintext']; //본문
  final title = Get.arguments['title']; //제목

  /* 제목 · 본문 Text Controller */
  TextEditingController _titleController = TextEditingController();
  TextEditingController _maintextController = TextEditingController();
  /* ScrollController 선언 */
  ScrollController _titleScrollController = ScrollController();
  ScrollController _maintextScrollController = ScrollController();
  ScrollController _scrollController = ScrollController();

  /* ListCycle
  * 기존 제목과 본문 수정페이지에 불러오기 */
  @override
  void initState() {
    super.initState();
    setState(() {
      _titleController.text = title;
      _maintextController.text = maintext;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(postId);
    print(_titleController.text);
    print(_maintextController.text);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading:
            IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
        title: Text('게시글 수정하기'),
        centerTitle: true,
        actions: [
          /* update 완료 버튼 */
          TextButton(
            onPressed: () async {
              await _postController.updatePost(
                postId,
                _titleController.text,
                _maintextController.text,
                _editDropDownController.seledtedPostGamemodeValue,
                _editDropDownController.seledtedPostdPositionValue,
                _editDropDownController.seledtedPostTearValue,
              );
              await _postController.getPostInfoByid(postId); //게시글 세부 페이지 새로고침
              Get.back(); //Post detail Page로 이동
            },
            child: Text(
              '완료',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: EditPostDropDownButton(),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              /* 제목입력란 */
              TextField(
                scrollController: _titleScrollController,
                maxLines: null,
                minLines: 1,
                showCursor: true,
                cursorColor: Colors.blue,
                controller: _titleController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '글 제목',
                  suffixIcon: _titleController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _titleController.clear();
                            setState(() {});
                          },
                        ),
                ),
                onSubmitted: (value) {
                  setState(() {});
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              /* 본문입력란 */
              TextField(
                maxLines: null,
                minLines: 1,
                scrollController: _maintextScrollController,
                showCursor: true,
                cursorColor: Colors.blue,
                controller: _maintextController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '자세하게 작성하면 매칭확률이 올라가요 :)',
                  suffixIcon: _maintextController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _maintextController.clear();
                            setState(() {});
                          },
                        ),
                ),
                onSubmitted: (value) {
                  setState(() {});
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}