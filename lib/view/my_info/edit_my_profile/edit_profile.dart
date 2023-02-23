import 'dart:io';
import 'package:gamegoapp/utilites/index/index.dart';

class EditMyProfilePage extends StatefulWidget {
  EditMyProfilePage({Key? key}) : super(key: key);

  @override
  State<EditMyProfilePage> createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameText = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);
  final MyProfileController _c = Get.find<MyProfileController>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 선택하거나 카메라로 찍은 사진 담는 변수
  File? _photoFile;
  // 파베 스토리지에서 불러올 사진 url
  String profileImageUrl = FirebaseAuth.instance.currentUser!.photoURL!;

  // 갤러리에서 사진 선택하기
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

  // 카메라로 사진 찍기
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

  // 파베 스토리지에 업로드하기
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

  // 닉네임 입력에 따른 에러 택스트
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
        automaticallyImplyLeading: false,
        title: Text(
          '프로필 설정',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        // body의 UI들이 가운데 정렬된 구성을 가지고 있어 이 페이지는 가운데로 함
        centerTitle: true,
        actions: [
          CustomCloseButton(),
        ],
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
                  AppSpaceData.heightLarge,
                  0,
                  AppSpaceData.heightMedium,
                ),
                child: Stack(
                  children: [
                    _photoFile == null
                        ? //갤러리에서 사진 선택하지 않은 경우 나의 기존 프로필 url
                        CircleAvatar(
                           backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(profileImageUrl),
                            radius: 85,
                          )
                        : //갤러리에서 사진 선택한 경우 선택한 파일의 이미지
                        CircleAvatar( backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(_photoFile!),
                            radius: 85,
                          ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appWhiteColor,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: appBlackColor,
                          size: 30,
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
              controller: _nameText,
              // 닉네임 최대글자 12자
              maxLength: 12,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              _showErrorText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(
          AppSpaceData.screenPadding,
        ),
        child: CustomFullFilledTextButton('완료', () async {
          // 닉네임
          final text = _nameText.text.trim();
          if (text.length >= 2 && text != _auth.currentUser!.displayName) {
            // 닉네임 2자 이상 + 닉네임을 수정 입력한 경우?

            if (_photoFile != null) {
              // 프로필을 변경한 경우
              // 선택한 갤러리의 사진을 storage에 올리고 url을 profileImageUrl에 받기
              await uploadFile();
              // 선택한 사진으로 프로필 업데이트
              _c.updateUserProfile(profileImageUrl);
            } else if (profileImageUrl != _auth.currentUser!.photoURL!) {
              // 기본프로필로 선택하면 ? _photoFile는 null도 된다
              _c.updateUserProfile(profileImageUrl);
            } else {
              null;
            }
            // 닉네임 수정 -> 유저정보 업데이트 -> Get.back()
            _c.updateUserName(text);
          } else {
            // 닉네임을 변경하지 않은 경우
            if (_photoFile != null) {
              // 프로필을 변경한 경우
              // 선택한 갤러리의 사진을 storage에 올리고 url을 profileImageUrl에 받기
              await uploadFile();
              // 선택한 사진으로 프로필 업데이트
              _c.updateUserProfile(profileImageUrl);
              // 유저정보 업데이트 후 페이지 닫기
              await _c.getUserInfoByUid(_auth.currentUser!.uid);
              Get.back();
            } else if (profileImageUrl != _auth.currentUser!.photoURL!) {
              // 기본프로필로 변경한 경우
              // 기본프로필로 선택하면 ? _photoFile는 null도 된다
              _c.updateUserProfile(profileImageUrl);
              // 유저정보 업데이트 후 페이지 닫기
              await _c.getUserInfoByUid(_auth.currentUser!.uid);
              Get.back();
            } else
              null;
          }
        }, appPrimaryColor),
      ),
    );
  }

  // 카메라 아이콘 클릭시 띄울 바텀시트
  showBottomSheet() {
    return Container(
      margin: EdgeInsets.all(AppSpaceData.screenPadding),
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtomSheet(
            '갤러리에서 사진 선택',
            appBlackColor,
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
            '기본 카메라로 사진 찍기',
            appBlackColor,
            () async {
              //카메라 권한 요청
              await PermissionHandler().requestCameraPermission().then(
                    (value) => value == true
                        // 허용된 권한 : 기본 카메라 실행
                        ? pickImgFromCamera()
                        // 허용되지 않은 권한 : 다시 권한 요청
                        : PermissionHandler().requestCameraPermission(),
                  );
              Get.back();
            },
          ),
          CustomButtomSheet(
            '기본 이미지로 설정',
            appBlackColor,
            () async {
              //기본 프로필 주소로 변경
              setState(() {
                _photoFile = null;
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
