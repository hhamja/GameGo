import 'package:mannergamer/utilites/index/index.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // PostController 선언 (∵ Create Post)
  final PostController _post = Get.find<PostController>();
  // 홈 드랍다운버튼 컨트롤러
  final HomePageDropDownBTController _ =
      Get.find<HomePageDropDownBTController>();
  // DropDownBTController 선언 (∵ Create Post)
  CreatePostDropDownBTController _button =
      Get.put(CreatePostDropDownBTController());
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
      // 게임모드를 선택했는지 여부
      if (_button.seledtedPostGamemodeValue == null) {
        // 버튼에서 아무 게임모드도 선택하지 않은 경우
        // 게임모드 선택하라고 유저에게 알리기}
        Get.snackbar(
          '',
          '',
          titleText: Text(
            '게임모드 선택 안함',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          messageText: Text(
            '버튼을 클릭하여 게임모드를 선택해주세요.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      } else {
        // 게임모드 선택한 경우
        final postModel = PostModel(
          postId: FirebaseFirestore.instance.collection('post').doc().id,
          uid: CurrentUser.uid,
          userName: CurrentUser.name,
          profileUrl: CurrentUser.profile,
          title: _titleController.text.trim(),
          maintext: _maintextController.text.trim(),
          gamemode: _button.seledtedPostGamemodeValue!,
          position: _button.seledtedPostdPositionValue,
          tear: _button.seledtedPostTearValue,
          like: 0,
          gameType: 'lol',
          isHidden: false,
          isDeleted: false,
          updatedAt: Timestamp.now(),
        );
        // 게시물 만들기
        await _post.createPost(postModel);
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
            // 모드, 포지션, 티어 드랍다운버튼
            AddPostDropDownButton(),
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
