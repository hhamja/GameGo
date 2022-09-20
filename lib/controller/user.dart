import 'package:mannergamer/utilites/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;
  /* FireStore User Collection Instance */
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('user');

  /* firestore User collection 담을 UserList */
  RxList<UserModel> userList = <UserModel>[].obs;

  /* 유저가입시 유저정보 담은 변수 */
  var user;
  /* 폰번호확인코드저장 */
  String verificationID = '';

  @override
  void onInit() {
    super.onInit();
    userList.bindStream(readUserList());
  }

  /* Create User */
  Future addNewUser(UserModel userModel) async {
    try {
      final res = await _user.doc(user.uid).set({
        'username': userModel.username,
        'avatar': userModel.avatar,
        'email': userModel.email,
        'mannerAge': userModel.mannerAge,
        'createdAt': userModel.createdAt,
      });
      return res;
    } catch (e) {
      print('addNewUser error = ${e}');
    }
  }

  /* 이메일 회원가입 */
  Future signUpEmail(String email, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  /* 이메일 로그인 */
  Future loginEmail(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  /* Read FireStore User DB  */
  Stream<List<UserModel>> readUserList() {
    return _user
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return UserModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 폰으로 SMS 전송 */
  Future verifyPhone(String phonenumber) async {
    try {
      await _auth.verifyPhoneNumber(
        /* 폰번호 입력 */
        phoneNumber: phonenumber,
        /* 폰인증 성공 시 */
        verificationCompleted: (PhoneAuthCredential credential) {},
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

  /* 폰가입정보 SignUP */
  Future signUP(token) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: token);
    final userCredential = await _auth.signInWithCredential(credential);
    user = userCredential.user;
    print(user?.uid);
  }

  /* 로그아웃 
  * 로그아웃의 경우 : 탈회하기랑은 다르게  자동로그인 쿠키만 앱에서 지움 */

  /* 탈퇴하기
  * DB User정보 삭제, 파베 Auth에서 해당 유저 삭제 */
  Future signOut() async {
    try {
      await _user.doc(user?.uid).delete();
      await _auth.signOut();
      print('탈퇴');
    } catch (e) {
      print('deleteUser error : ${e}');
    }
  }
}
