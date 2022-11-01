import 'package:mannergamer/utilites/index/index.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* UserDB Data 담을 UserList */
  RxList<UserModel> userList = <UserModel>[].obs;
  /* UID로 받은 유저정보 */
  RxMap<String, dynamic> userInfo = Map<String, dynamic>().obs;
  /* UserDB Data 담을 UserList */
  RxList userInfoList = [].obs;

  /* 폰번호확인코드저장 */
  String verificationID = '';

  /* Create User */
  Future addNewUser(UserModel userModel) async {
    try {
      await _userDB.doc(userModel.uid).set({
        'uid': userModel.uid,
        'userName': userModel.userName,
        'profileUrl': userModel.profileUrl,
        'mannerAge': userModel.mannerAge,
        'createdAt': userModel.createdAt,
        'phoneNumber': userModel.phoneNumber,
      });
    } catch (e) {
      print('addNewUser error = ${e}');
    }
  }

  /* 폰으로 SMS 전송 */
  Future verifyPhone(String phonenumber) async {
    try {
      await _auth.verifyPhoneNumber(
        //폰번호
        phoneNumber: phonenumber,
        //인증성공시
        verificationCompleted: (PhoneAuthCredential credential) {},

        // 잘못된 전화번호 또는 SMS 할당량 초과 여부 등과 같은 인증실패 시
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('인증실패', '잘못된 휴대폰 번호입니다.');
            print('The provided phone number is not valid.');
          } else {
            Get.snackbar('인증실패', '고객센터로 문의주세요.');
          }
        },
        /* 기기로 코드 전송 시 처리 */
        codeSent: (String verificationId, int? resendToken) {
          verificationID = verificationId;

          //sms코드를 자동으로 입력하는 autoFill을 넣자.(나중)
        },
        /* 자동 SMS 코드 처리가 실패할 때의 시간 초과를 처리 */
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 120),
      );
    } catch (e) {
      print(e);
    }
  }

  /* 폰가입정보 SignUP */
  Future signUP(token) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: token);
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    print(user?.uid);
  }

  /* 로그아웃 
  * Db,Auth정보 삭제 X  | 탈회하기랑은 다르게  자동로그인 쿠키만 앱에서 지움 */
  Future signOut() async {
    try {
      await _auth.signOut();
      print('로그아웃');
    } catch (e) {
      print('로그아웃 error : ${e}');
    }
  }

  /* 탈퇴하기
  * DB, Auth정보 삭제O | mainLogoPage()로 이동 */
  Future deleteUser(smsCode) async {
    try {
      // var ID;
      // await _auth.verifyPhoneNumber(
      //   //폰번호
      //   phoneNumber: _auth.currentUser!.phoneNumber,
      //   //인증성공시
      //   verificationCompleted: (PhoneAuthCredential credential) {},
      //   // 잘못된 전화번호 또는 SMS 할당량 초과 여부 등과 같은 인증실패 시
      //   verificationFailed: (FirebaseAuthException e) {},
      //   // 기기로 코드 전송 시 처리
      //   codeSent: (String verificationId, int? resendToken) {
      //     verificationId = ID;
      //   },
      //   /* 자동 SMS 코드 처리가 실패할 때의 시간 초과를 처리 */
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      //   timeout: const Duration(seconds: 120),
      // );

      final credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      print(credential);
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      await _auth.currentUser?.delete(); //Auth 정보 삭제
      await _userDB.doc(_auth.currentUser?.uid).delete(); //DB user정보 삭제
      print('탈퇴하기');
    } catch (e) {
      print('deleteUser error : ${e}');
    }
  }
}
