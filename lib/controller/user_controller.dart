import 'package:mannergamer/utilites/index.dart';

class UserController extends GetxController {
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  // /* 모든유저정보 */
  // late Rx<User?> firebaseUser;
  /* FireStore User Collection Instance */
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('user');

  /* User 정보 담을 UserList */
  RxList<UserModel> userList = <UserModel>[].obs;
  /* 유저매너나이 변수. 초기값=20, 변화공식 설정 어떻게? */
  RxDouble age = 20.0.obs;
  /* 폰번호확인코드저장 */
  String verificationID = '';

  /* 매너나이 변화 공식 */
  updownMannerAge() {}

  // @override
  // void onReady() {
  //   /* firebaseUser가 유저변화 반응형으로 감지하도록 함 */
  //   firebaseUser = Rx<User?>(_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  //   /* firebaseUser변화 감지해서 _setInitialScreen함수 실행 */
  //   ever(firebaseUser, _setInitialScreen);
  //   super.onReady();
  // }

  // /* 유저에 따라 다르게 첫화면 띄우기 */
  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     /* 유저정보 없으면, 시작하기 뜨는 페이지가 첫 ㄴ화면  */
  //     Get.offAllNamed('/login');
  //   } else {
  //     /* 유저정보 있으면, 바로 게시물리스트 있는 Homepage가 첫 화면 */
  //     Get.offAllNamed('/');
  //   }
  // }
  @override
  void onInit() {
    super.onInit();
    addNewUser;
    verifyPhone;
  }

  /* Create User */
  Future addNewUser(UserModel userModel) async {
    try {
      final res = await _user.add({
        'phonenumber': userModel.phonenumber,
        'username': userModel.username,
        'avatar': userModel.avatar,
        'email': userModel.email,
        'mannerAge': userModel.mannerAge,
        'createdAt': userModel.createdAt,
      });
      print(res);
      return res;
    } catch (e) {
      print('addNewUser error = ${e}');
    }
  }

  /* 유저 폰 번호로 SMS 전송 */
  Future verifyPhone(String phonenumber) async {
    try {
      await _auth.verifyPhoneNumber(
        /* 폰번호 입력 */
        phoneNumber: phonenumber,
        /* 폰인증 성공 시 */
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth
              .signInWithCredential(credential)
              .then((value) => print('전화번호인증선공'));
        },
        /* 잘못된 전화번호 또는 SMS 할당량 초과 여부와 같은 실패 이벤트를 처리 */
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print('폰인증 실패에러 -> ${e}');
        },
        /* 기기로 코드 전송 시 처리 */
        codeSent: (String verificationId, int? resendToken) {
          verificationID = verificationId;
        },
        /* 자동 SMS 코드 처리가 실패할 때의 시간 초과를 처리 */
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  /* 폰가입정보 SignIN */
  Future signIn(token) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: token);
    await _auth.signInWithCredential(credential);
  }

  /* 로그아웃 */
  Future signOut() async {
    await _auth.signOut();
  }
}
