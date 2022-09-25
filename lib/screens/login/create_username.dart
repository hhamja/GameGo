import 'dart:io';
import 'package:mannergamer/utilites/index.dart';

class CreateUserNamePage extends StatefulWidget {
  CreateUserNamePage({Key? key}) : super(key: key);

  @override
  State<CreateUserNamePage> createState() => _CreateUserNamePageState();
}

class _CreateUserNamePageState extends State<CreateUserNamePage> {
  /* FirebaseStorage instance */
  final FirebaseStorage _storage = FirebaseStorage.instance;
  /* FirebaseAuth instance */
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /* ImagePicker */
  final ImagePicker _picker = ImagePicker();
  /* 사진 담는 변수 */
  File? _photo;

  /* 갤러리에서 사진 선택하기 */
  Future pickImgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      //갤러리에 사진이 있다면?
      if (pickedFile != null) {
        _photo = File(pickedFile.path); //해당 이미지 담기 _photo변수에 담기
        uploadFile(); //파베 스토리지에 해당 이미지 저장
      } else {
        print('No image selected from Gallery');
      }
    });
  }

  /* 카메라로 사진 찍기 */
  Future pickImgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path); //해당 이미지 담기 _photo변수에 담기
        uploadFile(); //파베 스토리지에 해당 이미지 저장
      } else {
        print('No image selected from Camera');
      }
    });
  }

  /* 파베 스토리지에 업로드하기 */
  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = _storage.ref(destination).child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  final TextEditingController _userNameController = TextEditingController();
  /* User GetX Controller */
  final UserController _userAuth = Get.find<UserController>();

  /* 닉네임 입력에 따른 에러 택스트 */
  Text? get _showErrorText {
    final text = _userNameController.text.trim();
    if (text.isEmpty) {
      return Text(
        '닉네임을 입력해주세요!',
        style: TextStyle(color: Colors.red),
      );
    }
    if (text.length < 2) {
      return Text(
        '닉네임은 2자 이상 입력해주세요.',
        style: TextStyle(color: Colors.red),
      );
    }
    return Text('프로필 사진과 닉네임을 입력해주세요.');
  }

  /* 닉네임 입력에 따른 바텀 버튼 색 */
  Color? get _bottomButtonColorChange {
    final text = _userNameController.text.trim();

    if (text.isEmpty || text.length < 2) {
      //닉네임 2자 이상이라면?
      return Colors.grey;
    }
    return Colors.blue;
  }

  /* 완료 버튼 */
  validateButton() async {
    final text = _userNameController.text.trim();
    UserModel userModel = UserModel(
      username: text,
      mannerAge: 20,
      createdAt: Timestamp.now(),
    );
    if (!text.isEmpty || text.length >= 2) {
      //닉네임 2자 이상이라면?
      await _userAuth.addNewUser(userModel); //userDB에 저장
      await _auth.currentUser!.updateDisplayName(text); //userInfo에 닉네임저장
      Get.offAllNamed('/myapp'); //홈으로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    /* 카메라 아이콘 클릭시 띄울 모달 팝업 */
    Widget bottomSheet() {
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              '프로필 사진을 선택해주세요',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.camera,
                    size: 50,
                  ),
                  onPressed: () {
                    // takePhoto(ImageSource.camera);
                  },
                  label: Text(
                    '카메라',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.photo_library,
                    size: 50,
                  ),
                  onPressed: () {
                    // takePhoto(ImageSource.gallery);
                  },
                  label: Text(
                    '갤러리',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('프로필 설정'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: validateButton,
            child: Text(
              '완료',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Stack(
            children: [
              CircleAvatar(
                child: Icon(Icons.person_pin),
                backgroundImage: null, //
                radius: 80,
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    // 클릭시 모달 팝업을 띄워준다.
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  },
                  child: Icon(
                    Icons.camera_alt,
                    // color: secondaryTextColor,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          TextField(
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요.',
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                counterText: '',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              maxLines: 1,
              showCursor: true,
              controller: _userNameController,
              maxLength: 12,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                // setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'))
              ]),
          SizedBox(
            height: 10,
          ),
          Container(
            child: _showErrorText,
          )
        ],
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: _bottomButtonColorChange,
            child: TextButton(
              onPressed: validateButton,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('완료', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
