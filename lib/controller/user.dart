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
  /* LifeCycle */
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
  Future signupAndSigninToEmail(String email, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //이미 있다면, 바로 로긔인 수행하면 어떨까?
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  /* 이메일 로그인 */
  Future logInToEmail(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GetSnackBar(message: '이메일을 찾을 수 없습니다.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        GetSnackBar(message: '잘못된 비밀번호 입니다.');
        print('Wrong password provided for that user.');
      }
    }
  }

  /* Read FireStore User DB */
  Stream<List<UserModel>> readUserList() {
    return _user
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return UserModel.fromDocumentSnapshot(e);
            }).toList());
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
