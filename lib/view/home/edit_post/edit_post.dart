import 'package:gamegoapp/utilites/index/index.dart';

class EditPostPage extends StatefulWidget {
  EditPostPage({Key? key}) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final EditPostController _c = Get.put(EditPostController());
  final DetailPostController _detailPost = Get.put(DetailPostController());
  final postId = Get.arguments['postId'];
  final maintext = Get.arguments['maintext'];
  final title = Get.arguments['title'];

  // 제목 · 본문 Text Controller
  TextEditingController _titleController = TextEditingController();
  TextEditingController _maintextController = TextEditingController();
  // ScrollController 선언
  ScrollController _titleScrollController = ScrollController();
  ScrollController _maintextScrollController = ScrollController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _titleController.text = title;
      _maintextController.text = maintext;
    });
  }

  // 게시글 수정 '완료'버튼 클릭 시
  Future<void> _editPost() async {
    // 게임모드 미선택, 제목과 내용 미작성 시
    if (_c.seledtedPostGamemodeValue == null ||
        _titleController.text == '' ||
        _maintextController.text == '') {
      // 다이얼로그로 유저에게 알림
      Get.dialog(
        CustomOneButtonDialog(
          '게임모드, 제목, 내용은 필수 입력 항목이에요.',
          '확인',
          () => Get.back(),
        ),
      );
    } else {
      // 서버의 게시글 데이터 업데이트
      await _c.updatePost(
        postId,
        _titleController.text,
        _maintextController.text,
        _c.seledtedPostGamemodeValue,
        _c.seledtedPostdPositionValue,
        _c.seledtedPostTearValue,
      );
      // 게시글 세부 페이지 새로고침
      await _detailPost.getPostInfoByid(postId);
      // Post detail Page로 이동
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomCloseButton(),
        title: Text(
          '게시글 수정하기',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          // 완료 버튼
          TextButton(
            onPressed: _editPost,
            child: Text(
              '완료',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight,
                letterSpacing:
                    Theme.of(context).textTheme.titleMedium!.letterSpacing,
                color: appPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: Column(
          children: [
            // 모드, 포지션, 티어 드랍다운버튼
            EditPostDropDownButton(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                    height: 30.sp,
                    color: appGreyColor,
                  ),
                  // 제목입력
                  TextField(
                    cursorColor: cursorColor,
                    scrollController: _titleScrollController,
                    maxLines: null,
                    minLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    showCursor: true,
                    controller: _titleController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: appGreyColor,
                      ),
                      hintText: '글 제목',
                      suffixIcon: _titleController.text.isEmpty
                          ? null
                          : IconButton(
                              // 드랍다운 버튼과 오른쪽 끝선을 맞추기 위한 수치
                              padding: EdgeInsets.all(3.sp),
                              alignment: Alignment.centerRight,
                              icon: Icon(
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
                    height: 30.sp,
                    color: appGreyColor,
                  ),
                  // 본문입력
                  TextField(
                    cursorColor: cursorColor,
                    maxLines: null,
                    minLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    scrollController: _maintextScrollController,
                    showCursor: true,
                    controller: _maintextController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: appGreyColor,
                      ),
                      hintText: '자세하게 작성하면 매칭확률이 올라가요 :)',
                      suffixIcon: _maintextController.text.isEmpty
                          ? null
                          : IconButton(
                              // 드랍다운 버튼과 오른쪽 끝선을 맞추기 위한 수치
                              padding: EdgeInsets.all(3.sp),
                              alignment: Alignment.centerRight,
                              icon: Icon(
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
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
