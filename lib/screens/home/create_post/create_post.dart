import 'package:mannergamer/utilites/index.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  /* PostController 선언 (∵ Create Post) */
  final PostController _postController = Get.find<PostController>();
  /* DropDownBTController 선언 (∵ Create Post) */
  CreatePostDropDownBTController dropDownController =
      Get.put(CreatePostDropDownBTController());
  /* 제목 · 본문 Text Controller */
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _maintextController = TextEditingController();
  /* ScrollController */
  final ScrollController _titleScrollController = ScrollController();
  final ScrollController _maintextScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

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
            onPressed: () async {
              //uid로 해당유저의 data UserModel의 인스턴스의 담기
              UserModel userModel =
                  await _userDB.doc(_auth.currentUser!.uid).get().then((value) {
                return UserModel.fromDocumentSnapshot(value);
              });
              //postModel 인스턴스 생성
              final postModel = PostModel(
                postId: FirebaseFirestore.instance.collection('post').doc().id,
                uid: _auth.currentUser!.uid,
                mannerAge: userModel.mannerAge.toString(),
                userName: userModel.userName.toString(),
                profileUrl: userModel.profileUrl.toString(),
                title: _titleController.text.trim(),
                maintext: _maintextController.text.trim(),
                gamemode: dropDownController.seledtedPostGamemodeValue,
                position: dropDownController.seledtedPostdPositionValue,
                tear: dropDownController.seledtedPostTearValue,
                createdAt: Timestamp.now(),
              );
              //게시물 만들기
              await _postController.createPost(postModel);
              Get.back();
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