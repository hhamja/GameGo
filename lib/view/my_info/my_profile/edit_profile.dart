import 'dart:io';
import 'package:mannergamer/utilites/index/index.dart';

class EditMyProfilePage extends StatefulWidget {
  EditMyProfilePage({Key? key}) : super(key: key);

  @override
  State<EditMyProfilePage> createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  final TextEditingController _nameText = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName!);
  final UserController _user = Get.put(UserController());
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  /* 갤러리에서 선택하거나 카메라로 찍은 사진 담는 변수 */
  File? _photoFile;
  /* 파베 스토리지에서 불러올 사진 url */
  String profileImageUrl = FirebaseAuth.instance.currentUser!.photoURL!;

  /* 갤러리에서 사진 선택하기 */
  Future pickImgFromGallery() async {
    //갤러리에서 선택한 사진이 경로
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      //갤러리에 사진이 있다면?
      if (pickedFile != null) {
        _photoFile = File(pickedFile.path); //해당 이미지 담기 _photofile변수에 담기
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
        _photoFile = File(pickedFile.path); //해당 이미지 담기 _photofile변수에 담기
      } else {
        print('No image selected from Camera');
      }
    });
  }

  /* 파베 스토리지에 업로드하기 */
  Future uploadFile() async {
    if (_photoFile == null) return;
    final fileName = _auth.currentUser?.uid; //유저고유 id값을 파일명으로

    try {
      //('storage/profile/{uid}') 경로
      final ref = _storage.ref().child('profile').child(fileName!);
      print(ref);
      print(_photoFile);
      await ref.putFile(_photoFile!); //스토리지에 업로드
      profileImageUrl = await ref.getDownloadURL(); //업로드한 사진 url받기
      print(profileImageUrl);
    } catch (e) {
      print(e);
    }
  }

  /* 닉네임 입력에 따른 에러 택스트 */
  String get _showErrorText {
    final text = _nameText.text.trim();

    if (text.isEmpty || text.length < 2) {
      return '특수문자를 제외한 2자 이상 입력해주세요.';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('프로필 설정'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            /* 프로필 설정 */
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 40,
              ),
              child: Stack(
                children: [
                  _photoFile == null
                      ? //갤러리에서 사진 선택하지 않은 경우 나의 기존 프로필 url
                      CircleAvatar(
                          backgroundImage: NetworkImage(profileImageUrl),
                          radius: 80,
                        )
                      : //갤러리에서 사진 선택한 경우 선택한 파일의 이미지
                      CircleAvatar(
                          backgroundImage: FileImage(_photoFile!),
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
            ),

            /* 닉네임 입력란 */
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
              controller: _nameText,
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: CustomTextButton(
          '완료',
          () async {
            final text = _nameText.text.trim(); //닉네임
            //닉네임 2자 이상 + 닉네임을 수정 입력한 경우?
            if (text.length >= 2 && text != CurrentUser.name) {
              _user.updateUserName(text); ////닉네임 수정
            }
            //프로필을 변경한 경우
            if (_photoFile != null) {
              //선택한 갤러리의 사진을 storage에 올리고 url을 profileImageUrl에 받기
              await uploadFile();
              print(profileImageUrl);
              //선택한 사진으로 프로필 업데이트
              _user.updateUserProfile(profileImageUrl);
            } else if (profileImageUrl != CurrentUser.profile) {
              print(profileImageUrl);
              //기본프로필로 선택하면 ? _photoFile는 null도 된다
              _user.updateUserProfile(profileImageUrl);
            }

            //내정보 새로고침
            _user.getUserInfoByUid(CurrentUser.uid);
            Get.back();
          },
        ),
      ),
    );
  }

  /* 카메라 아이콘 클릭시 띄울 바텀시트 */
  showBottomSheet() {
    return Container(
      height: 240,
      color: Colors.white, //투염도 설정(나중)
      child: Column(
        children: [
          CustomButtomSheet(
            '갤러리에서 사진 선택',
            Colors.blue,
            () async {
              await pickImgFromGallery();
              Get.back();
            },
          ),
          CustomButtomSheet(
            '기본 카메라로 사진 찍기',
            Colors.blue,
            () async {
              await pickImgFromCamera();
              Get.back();
            },
          ),
          CustomButtomSheet(
            '기본 이미지로 설정',
            Colors.blue,
            () async {
              //기본 프로필 주소로 변경
              setState(() {
                _photoFile = null;
                profileImageUrl = DefaultProfle.url;
              });
              Get.back();
            },
          ),
          CustomButtomSheet(
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
