import 'package:mannergamer/utilites/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  /* FirebaseAuth instance */
  final _auth = FirebaseAuth.instance;

  /* FireStore User Collection Instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* firestore User collection 담을 UserList */
  RxList<UserModel> userList = <UserModel>[].obs;

  /* LifeCycle */
  @override
  void onInit() {
    super.onInit();
    userList.bindStream(readUserList());
  }

  /* Create User */
  Future addNewUser(UserModel userModel) async {
    try {
      final res = await _userDB.doc(_auth.currentUser?.uid).set({
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

  /* Read FireStore User DB */
  Stream<List<UserModel>> readUserList() {
    return _userDB
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return UserModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 이메일 회원가입 */
  Future signUpToEmail(String email, password) async {
    print(_auth.currentUser?.emailVerified);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(userCredential.user!.emailVerified);
      if (userCredential.user!.emailVerified == false) {
        userCredential.user?.sendEmailVerification();
        Get.snackbar('인증메일발송 ', '해당 이메일에서 본인을 인증해주세요.');
        print(userCredential.user!.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('', '이미 가입한 이메일 계정입니다.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  /* 이메일 로그인 */
  Future signInToEmail(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/myapp');
    } on FirebaseAuthException catch (e) {
      // 가입 X 이메일 입력 시
      if (e.code == 'user-not-found') {
        Get.snackbar('', '가입되어 있지 않은 이메일입니다.');
        print('No user found for that email.');
        // 이메일은 있지만 패스워드가 틀린 경우
      } else if (e.code == 'wrong-password') {
        Get.snackbar('', '비밀번호가 일치하지 않습니다.');
        print('Wrong password provided for that user.');
      }
    }
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
  Future deleteUser() async {
    try {
      await _auth.currentUser!.delete(); //Auth 정보 삭제
      await _userDB.doc(_auth.currentUser!.uid).delete(); //DB user정보 삭제
      print('탈퇴하기');
    } catch (e) {
      print('deleteUser error : ${e}');
    }
  }
}
