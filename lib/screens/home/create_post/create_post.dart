import 'package:mannergamer/utilites/index/index.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _auth = FirebaseAuth.instance;
  /* 유저 DB Ref */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* PostController 선언 (∵ Create Post) */
  final PostController _post = Get.find<PostController>();
  /* 홈 드랍다운버튼 컨트롤러 */
  final HomePageDropDownBTController _ =
      Get.find<HomePageDropDownBTController>();
  /* DropDownBTController 선언 (∵ Create Post) */
  CreatePostDropDownBTController _button =
      Get.put(CreatePostDropDownBTController());
  /* 제목 · 본문 Text Controller */
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _maintextController = TextEditingController();
  /* ScrollController */
  final ScrollController _titleScrollController = ScrollController();
  final ScrollController _maintextScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  /* 게시글 생성 '완료'버튼 클릭 시 */
  Future<void> _createPost() async {
    UserModel userModel =
        await _userDB.doc(_auth.currentUser!.uid).get().then((value) {
      return UserModel.fromDocumentSnapshot(value);
    }); //uid로 해당유저의 data UserModel의 인스턴스의 담기

    final postModel = PostModel(
      postId: FirebaseFirestore.instance.collection('post').doc().id,
      uid: _auth.currentUser!.uid,
      mannerAge: userModel.mannerAge.toString(),
      userName: userModel.userName.toString(),
      profileUrl: userModel.profileUrl.toString(),
      title: _titleController.text.trim(),
      maintext: _maintextController.text.trim(),
      gamemode: _button.seledtedPostGamemodeValue,
      position: _button.seledtedPostdPositionValue,
      tear: _button.seledtedPostTearValue,
      like: 0,
      createdAt: Timestamp.now(),
    ); //postModel 인스턴스 생성

    await _post.createPost(postModel); //게시물 만들기

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
        title: Text('매너게이머 글쓰기'),
        centerTitle: true,
        actions: [
          /* 완료 버튼 */
          TextButton(
            onPressed: _createPost,
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
                child: AddPostDropDownButton(),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),

              /* 제목 입력 란 */
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

              /* 본문 입력 란 */
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
