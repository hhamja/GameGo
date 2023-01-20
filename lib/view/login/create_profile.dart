import 'dart:io';
import 'package:mannergamer/utilites/index/index.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _userNameController = TextEditingController();
  final UserController _user = Get.put(UserController());
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  /* 갤러리에서 선택하거나 카메라로 찍은 사진 담는 변수 */
  File? _photo;
  /* 파베 스토리지에서 불러올 사진 url */
  String profileImageUrl = DefaultProfle.url;

  /* 갤러리에서 사진 선택하기 */
  Future pickImgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      //갤러리에 사진이 있다면?
      if (pickedFile != null) {
        _photo = File(pickedFile.path); //해당 이미지 담기 _photo변수에 담기
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

  /* 닉네임 입력에 따른 에러 택스트 */
  String get _showErrorText {
    final text = _userNameController.text.trim();

    if (text.isEmpty || text.length < 2) {
      return '특수문자를 제외한 2자 이상 입력해주세요.';
    }
    return '';
  }

  /* 완료 버튼 */
  validateButton() async {
    // 알림 권한에 대한 상태 값 받기
    final _isGrantedNtf = await Permission.notification.status.isGranted;
    final text = _userNameController.text.trim(); //닉네임
    //닉네임 2자 이상이라면?
    if (!text.isEmpty || text.length >= 2) {
      //파베 스토리지에 해당 이미지 보내고 url 받기
      //await 이유 : profileUrl변수를 먼저 받아야함
      await uploadFile();
      UserModel userModel = UserModel(
          uid: _auth.currentUser!.uid,
          userName: text,
          phoneNumber: Get.arguments ??
              _auth.currentUser!.phoneNumber, //인증받은 폰번호 이전페이지에서 받기
          profileUrl: profileImageUrl,
          mannerAge: 20.0,
          chatPushNtf: _isGrantedNtf,
          activityPushNtf: _isGrantedNtf,
          noticePushNtf: _isGrantedNtf,
          //광고성 수신 동의는 처음에 물어보지 않고 유저가 설정했을 때만
          marketingConsent: false,
          createdAt: Timestamp.now());
      //서버에 유저정보 보내기
      _user.addNewUser(userModel);
      //Auth에 프로필 URL저장
      _auth.currentUser!.updatePhotoURL(profileImageUrl);
      //Auth에 닉네임저장
      _auth.currentUser!.updateDisplayName(text);

      //홈으로 이동
      Get.offAllNamed('/myapp');
    }
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
                  _photo == null
                      ? //갤러리에서 사진 선택하지 않은 경우 나의 기존 프로필 url
                      CircleAvatar(
                          backgroundImage: NetworkImage(profileImageUrl),
                          radius: 80,
                        )
                      : //갤러리에서 사진 선택한 경우 선택한 파일의 이미지
                      CircleAvatar(
                          backgroundImage: FileImage(_photo!),
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: CustomTextButton(
          '완료',
          validateButton,
        ),
      ),
    );
  }

  /* 카메라 아이콘 클릭시 띄울 바텀시트 */
  Container showBottomSheet() {
    return Container(
      height: 240,
      color: Colors.white, //투염도 설정(나중)
      child: Column(
        children: [
          CustomButtomSheet(
            '갤러리에서 사진 선택',
            Colors.blue,
            () async {
              //갤러리 권한 요청
              await PermissionHandler().requestStoragePermission().then(
                    (value) => value == true
                        // 허용된 권한 : 사진 저장소 실행
                        ? pickImgFromGallery()
                        // 허용되지 않은 권한 : 다시 권한 요청
                        : PermissionHandler().requestStoragePermission(),
                  );
              Get.back();
            },
          ),
          CustomButtomSheet(
            '기본 카메라로 사진 찍기', // ★★★★★카메라 권한 요청
            Colors.blue,
            () async {
              //카메라 권한 요청
              await PermissionHandler().requestCameraPermission().then(
                    (value) => value == true
                        // 허용된 권한 : 기본 카메라 실행
                        ? pickImgFromCamera()
                        // 허용되지 않은 권한 : 다시 권한 요청
                        : PermissionHandler().requestCameraPermission(),
                  );
              //카메라에서 사진 찍고 프로필 + 스토리지 업로드하기
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
                _photo = null;
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
