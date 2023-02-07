import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _auth = FirebaseAuth.instance;
  // 유저 DB Ref
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
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

  // 게시글 생성 '완료'버튼 클릭 시
  Future<void> _createPost() async {
    UserModel userModel =
        await _userDB.doc(_auth.currentUser!.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    }); //uid로 해당유저의 data UserModel의 인스턴스의 담기

    final postModel = PostModel(
      postId: FirebaseFirestore.instance.collection('post').doc().id,
      uid: _auth.currentUser!.uid,
      userName: userModel.userName.toString(),
      profileUrl: userModel.profileUrl.toString(),
      title: _titleController.text.trim(),
      maintext: _maintextController.text.trim(),
      gamemode: _button.seledtedPostGamemodeValue,
      position: _button.seledtedPostdPositionValue,
      tear: _button.seledtedPostTearValue,
      like: 0,
      gameType: 'lol',
      isHidden: false,
      isDeleted: false,
      updatedAt: Timestamp.now(),
    ); //postModel 인스턴스 생성

    await _post.createPost(postModel); //게시물 만들기

    // 드랍다운버튼 선택의 대한 IF문
    if (_.selectedTearValue != '티어') {
      await _post.filterTear(
          _.selectedModeValue, _.selectedPositionValue, _.selectedTearValue);
    } //티어 선택한 경우( = 3개 다 선택한 경우)
    else if (_.selectedPositionValue != '포지션') {
      await _post.filterPosition(_.selectedModeValue, _.selectedPositionValue);
    } //티어 선택 X, 모드와 포지션을 선택한 경우
    else if (_.selectedModeValue != '게임모드') {
      await _post.filterGamemode(_.selectedModeValue);
    } // 티어, 포지션 선택 X, 게임모드만 선택한 경우
    else {
      await _post.readPostData();
    } //티어, 포지션, 게임모드 아무것도 선택하지 않은 경우

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
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
                    color: appGrayColor,
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
                        color: appGrayColor,
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
                    color: appGrayColor,
                  ),
                  // 본문입력
                  TextField(
                    maxLines: null,
                    minLines: 1,
                    scrollController: _maintextScrollController,
                    showCursor: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    cursorColor: Colors.blue,
                    controller: _maintextController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: appGrayColor,
                      ),
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
