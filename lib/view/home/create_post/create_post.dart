import 'package:gamegoapp/utilites/index/index.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CreatePostController _c = Get.put(CreatePostController());

  // 제목 · 본문 Text Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _maintextController = TextEditingController();
  // ScrollController
  final ScrollController _titleScrollController = ScrollController();
  final ScrollController _maintextScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // 게시글 생성 '완료'버튼 클릭 시
    Future<void> _createPost() async {
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
        // 게임모드 선택, 제목작성, 글 내용작성 모두 한 경우
        final postModel = PostModel(
          postId: FirebaseFirestore.instance.collection('post').doc().id,
          uid: _auth.currentUser!.uid,
          userName: _auth.currentUser!.displayName!,
          profileUrl: _auth.currentUser!.photoURL!,
          title: _titleController.text.trim(),
          maintext: _maintextController.text.trim(),
          gamemode: _c.seledtedPostGamemodeValue!,
          position: _c.seledtedPostdPositionValue,
          tear: _c.seledtedPostTearValue,
          like: 0,
          gameType: 'lol',
          isHidden: false,
          isDeleted: false,
          updatedAt: Timestamp.now(),
        );
        // 게시물 만들기
        await _c.createPost(postModel);
        Get.back();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomCloseButton(),
        title: Text(
          '글쓰기',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          // 완료 버튼
          TextButton(
            onPressed: _createPost,
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
            SizedBox(height: 20),
            // 모드, 포지션, 티어 드랍다운버튼
            AddPostDropDownButton(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceData.screenPadding),
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                    height: 40,
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
                              padding: EdgeInsets.all(4),
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
                    height: 40,
                    color: appGreyColor,
                  ),
                  // 본문입력
                  TextField(
                    cursorColor: cursorColor,
                    maxLines: null,
                    minLines: 1,
                    scrollController: _maintextScrollController,
                    showCursor: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: _maintextController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: appGreyColor,
                      ),
                      hintText: '글 내용을 작성해주세요 :)',
                      suffixIcon: _maintextController.text.isEmpty
                          ? null
                          : IconButton(
                              // 드랍다운 버튼과 오른쪽 끝선을 맞추기 위한 수치
                              padding: EdgeInsets.all(4),
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
              padding: EdgeInsets.all(
                MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
