import 'dart:io';
import 'package:gamego/utilites/index/index.dart';

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
  // 갤러리에서 선택하거나 카메라로 찍은 사진 담는 변수
  File? _photo;
  // 파베 스토리지에서 불러올 사진 url
  String profileImageUrl = DefaultProfle.url;

  // 갤러리에서 사진 선택하기
  Future pickImgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      // 갤러리에 사진이 있다면?
      if (pickedFile != null) {
        // 해당 이미지 담기 _photo변수에 담기
        _photo = File(pickedFile.path);
      } else {
        print('No image selected from Gallery');
      }
    });
  }

  // 카메라로 사진 찍기
  Future pickImgFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      if (pickedFile != null) {
        // 해당 이미지 담기 _photo변수에 담기
        _photo = File(pickedFile.path);
      } else {
        print('No image selected from Camera');
      }
    });
  }

  // 파베 스토리지에 업로드하기
  Future uploadFile() async {
    if (_photo == null) return;
    //　유저고유 id값을 파일명으로
    final fileName = _auth.currentUser?.uid;
    try {
      // storage > profile 폴더 > filename의 파일 경로
      final ref = _storage.ref().child('profile').child(fileName!);
      // 스토리지에 업로드
      await ref.putFile(_photo!);
      profileImageUrl = await ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  // 닉네임 입력에 따른 에러 택스트
  String get _showErrorText {
    final text = _userNameController.text.trim();

    if (text.isEmpty || text.length < 2) {
      return '특수문자를 제외한 2자 이상 입력해주세요.';
    }
    return '';
  }

  // 완료버튼
  validateButton() async {
    // 알림 권한에 대한 상태 값 받기
    final _isGrantedNtf = await Permission.notification.status.isGranted;
    // 닉네임
    final text = _userNameController.text.trim();
    // 닉네임 2자 이상이라면?
    if (!text.isEmpty || text.length >= 2) {
      // 파베 스토리지에 해당 이미지 보내고 url 받기
      // await 이유 : profileUrl변수를 먼저 받아야함
      await uploadFile();
      UserModel userModel = UserModel(
        uid: _auth.currentUser!.uid,
        userName: text,
        //인증받은 폰번호 이전페이지에서 받기
        phoneNumber: _auth.currentUser!.phoneNumber.toString(),
        profileUrl: profileImageUrl,
        // 3000은 Lv.30 의미
        mannerLevel: 3000,
        chatPushNtf: _isGrantedNtf,
        activityPushNtf: _isGrantedNtf,
        // 광고성 수신 동의는 처음에 물어보지 않고 유저가 설정했을 때만
        marketingConsent: false,
        // 야간 알림은 데이터만 넣어놓고 UI는 표시 X
        nightPushNtf: false,
        isWithdrawn: false,
        updatedAt: Timestamp.now(),
        createdAt: Timestamp.now(),
      );
      // 서버에 유저정보 보내기
      _user.addNewUser(userModel);
      // auth에 닉네임, 프로필 저장
      _auth.currentUser!.updatePhotoURL(profileImageUrl);
      _auth.currentUser!.updateDisplayName(text);
      // 홈으로 이동
      Get.offAllNamed('/myapp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '프로필 설정',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        // body의 UI들이 가운데 정렬된 구성을 가지고 있어 이 페이지는 가운데로 함
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            // 프로필 설정
            GestureDetector(
              // 클릭시 모달 팝업을 띄워준다.
              onTap: () => Get.bottomSheet(showBottomSheet()),
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  0,
                  // 앱바와의 거리
                  AppSpaceData.heightLarge,
                  0,
                  // 닉네임 입력 칸과의 거리
                  AppSpaceData.heightMedium,
                ),
                child: Stack(
                  children: [
                    _photo == null
                        ? // 갤러리에서 사진 선택하지 않은 경우 나의 기존 프로필 url
                        CircleAvatar(
                            // 투명색
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(profileImageUrl),
                            radius: 65.sp,
                          )
                        : // 갤러리에서 사진 선택한 경우 선택한 파일의 이미지
                        CircleAvatar(
                            // 투명색
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(_photo!),
                            radius: 65.sp,
                          ),
                    Positioned(
                      bottom: 6.sp,
                      right: 6.sp,
                      child: Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: appWhiteColor),
                        child: Icon(
                          Icons.camera_alt,
                          color: appBlackColor,
                          size: 23.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 닉네임 입력란
            TextFormField(
              cursorColor: cursorColor,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: '닉네임을 입력해주세요 :)',
                fillColor: appWhiteColor,
                hintStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: appGreyColor,
                ),
                labelText: '-------- 닉네임 --------',
                labelStyle: Theme.of(context).textTheme.titleSmall,
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
                setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'))
              ],
            ),
            SizedBox(height: 3.sp),
            Text(
              _showErrorText,
              style: TextStyle(
                fontSize: 12.sp,
                letterSpacing: 0.5,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(
          AppSpaceData.screenPadding,
        ),
        child: CustomFullFilledTextButton(
          '완료',
          validateButton,
          appPrimaryColor,
        ),
      ),
    );
  }

  // 카메라 아이콘 클릭시 띄울 바텀시트
  Container showBottomSheet() {
    return Container(
      margin: EdgeInsets.all(AppSpaceData.screenPadding * 0.5),
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      height: 160.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtomSheet(
            '갤러리에서 사진 선택',
            appBlackColor,
            () async {
              // 갤러리 권한 요청
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
            '기본 카메라로 사진 찍기',
            appBlackColor,
            () async {
              // 카메라 권한 요청
              await PermissionHandler().requestCameraPermission().then(
                    (value) => value == true
                        // 허용된 권한 : 기본 카메라 실행
                        ? pickImgFromCamera()
                        // 허용되지 않은 권한 : 다시 권한 요청
                        : PermissionHandler().requestCameraPermission(),
                  );
              // 카메라에서 사진 찍고 프로필 + 스토리지 업로드하기
              await pickImgFromCamera();
              Get.back();
            },
          ),
          CustomButtomSheet(
            '기본 이미지로 설정',
            appBlackColor,
            () async {
              // 기본 프로필 주소로 변경
              setState(() {
                _photo = null;
                profileImageUrl = DefaultProfle.url;
              });
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
