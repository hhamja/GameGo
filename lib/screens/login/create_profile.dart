import 'dart:io';
import 'package:mannergamer/utilites/index.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  /* Firebase Storage instance */
  final FirebaseStorage _storage = FirebaseStorage.instance;
  /* Firebase Auth instance */
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /* ImagePicker */
  final ImagePicker _picker = ImagePicker();
  /* 갤러리에서 선택하거나 카메라로 찍은 사진 담는 변수 */
  File? _photo;
  /* 파베 스토리지에서 불러올 사진 url */
  String? profileImageUrl;

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
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
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
    final fileName = _auth.currentUser?.uid; //유저고유 id값을 파일명으로

    try {
      //storage > profile 폴더 > filename의 파일 경로
      final ref = _storage.ref().child('profile').child(fileName!);
      print(ref);
      print(_photo);
      await ref.putFile(_photo!); //스토리지에 업로드
      profileImageUrl = await ref.getDownloadURL();
      print(profileImageUrl);
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController _userNameController = TextEditingController();
  /* User GetX Controller */
  final UserController _userAuth = Get.find<UserController>();

  /* 닉네임 입력에 따른 에러 택스트 */
  String get _showErrorText {
    final text = _userNameController.text.trim();

    if (text.isEmpty || text.length < 2) {
      return '특수문자를 제외한 2자 이상 입력해주세요.';
    }
    return '';
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
      phoneNumber: Get.arguments,
      profileUrl: profileImageUrl,
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
          SizedBox(height: 40),
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: _photo == null
                    ? NetworkImage(_storage
                            .ref()
                            .child('profile')
                            .child('default_profile.png')
                            .getDownloadURL()
                            .toString()
                        // 기본 프로필 url
                        // 'https://firebasestorage.googleapis.com/v0/b/mannergamer-c2546.appspot.com/o/profile%2Fdefault_profile.png?alt=media&token=4a999f41-c0f9-478b-b0ee-d88e5364c689'
                        )
                    // 사용자 설정 url
                    : NetworkImage(profileImageUrl!),
                radius: 80,
              ),
              Positioned(
                bottom: 7,
                right: 7,
                child: GestureDetector(
                  // 클릭시 모달 팝업을 띄워준다.
                  onTap: () => Get.bottomSheet(showBottomSheet()),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              hintText: '닉네임을 입력해주세요 :)',
              fillColor: Colors.white,
              labelText: '-------- 닉네임 --------',
              counterText: '',
              border: InputBorder.none,
            ),
            autocorrect: false,
            textInputAction: TextInputAction.done,
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
            ],
          ),
          SizedBox(height: 10),
          Text(
            _showErrorText,
            style: TextStyle(color: Colors.red),
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

  /* 카메라 아이콘 클릭시 띄울 바텀시트 */
  Widget showBottomSheet() {
    return Container(
      height: 240,
      color: Colors.white, //투염도 설정(나중)
      child: Column(
        children: [
          ButtomSheetContent(
            '갤러리에서 사진 선택', // ★★★★★갤러리 권한 요청
            Colors.blue,
            () async {
              //갤러리에서 사진 가져오고 프로필 + 스토리지 업로드하기
              await pickImgFromGallery();
              Get.back();
            },
          ),
          ButtomSheetContent(
            '기본 카메라로 사진 찍기', // ★★★★★카메라 권한 요청
            Colors.blue,
            () async {
              //카메라에서 사진 찍고 프로필 + 스토리지 업로드하기
              await pickImgFromCamera();
              Get.back();
            },
          ),
          ButtomSheetContent(
            '기본 이미지로 설정',
            Colors.blue,
            () {
              //스토리지, 프로필 이미지 제거 후 기본 프로필 사진으로
              setState(() {
                _photo = null;
              });
              Get.back();
            },
          ),
          ButtomSheetContent(
            '취소',
            Colors.black,
            () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
