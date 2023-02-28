import 'package:gamegoapp/utilites/index/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _reviewDB =
      FirebaseFirestore.instance.collection('gameReview');
  GoogleSignInAuthentication? googleAuth;

  // 구글 소셜 로그인으로 가입
  Future signInWithGoogle() async {
    // 구글 로그인하는 창 띄우기
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // 구글 로그인 정보 받기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // credentail 생성
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // 가입하기
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // // 구글 소셜 로그인으로 가입
  // Future signInWithGoogleCredential() async {}

  // 유저 정보 DB에 추가
  Future addNewUser(UserModel userModel) async {
    _userDB.doc(userModel.uid).set(
      {
        'uid': userModel.uid,
        'userName': userModel.userName,
        'profileUrl': userModel.profileUrl,
        'mannerLevel': userModel.mannerLevel,
        'chatPushNtf': userModel.chatPushNtf,
        'activityPushNtf': userModel.activityPushNtf,
        'marketingConsent': userModel.marketingConsent,
        'nightPushNtf': userModel.nightPushNtf,
        'isWithdrawn': userModel.isWithdrawn,
        'withdrawnAt': userModel.withdrawnAt,
        'updatedAt': userModel.updatedAt,
        'createdAt': userModel.createdAt,
      },
    );
  }

  // 로그아웃
  Future signOut() async {
    // 로그아웃시 푸시알림 수신 못하게 하기 위해 토큰값 null로 업데이트
    _userDB.doc(_auth.currentUser?.uid).update(
      {
        'pushToken': null,
      },
    );
    // 유저정보 토큰값을 앱 로컬에서 지우기
    _auth.signOut();
  }

  // 탈퇴하기
  Future deleteUser() async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();
    try {
      final QuerySnapshot postSnapshot = await _postDB
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .where('isDeleted', isEqualTo: false)
          .where('isHidden', isEqualTo: false)
          .get();
      final QuerySnapshot chatSnapshot = await _chatDB
          .where('members', arrayContains: _auth.currentUser!.uid)
          .where('isActive', isEqualTo: true)
          .get();
      final QuerySnapshot reviewSnapshot = await _reviewDB
          .where('idFrom', isEqualTo: _auth.currentUser!.uid)
          .get();
      // 게시글 플래그 처리
      postSnapshot.docs.forEach(
        (doc) {
          _batch.update(
            doc.reference,
            {'isHidden': true},
          );
        },
      );
      // 탈퇴유저의 채팅방 플래그 처리
      chatSnapshot.docs.forEach(
        (doc) {
          _batch.update(
            doc.reference,
            {'isActive': false},
          );
        },
      );
      // 게임후기의 프로필 기본 프로필로 수정
      reviewSnapshot.docs.forEach(
        (doc) {
          _batch.update(
            doc.reference,
            {'profileUrl': DefaultProfle.url},
          );
        },
      );

      // 유저정보 탈퇴 플래그, 탈퇴 시간 업데이트
      _batch.update(
        _userDB.doc(_auth.currentUser!.uid),
        {
          'isWithdrawn': true,
          'withdrawnAt': Timestamp.now(),
        },
      );
      await _batch.commit();
      // // Storage에서 해당 유저의 프로필 삭제
      // FirebaseStorage.instance.ref().child(CurrentUser.uid).delete();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // 사용자 재인증
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      // 장치에 저장된 유저 토큰 삭제
      _auth.currentUser!.delete();
      debugPrint('탈퇴 성공');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        // SMS 코드가 틀린 경우
        // 스낵바로 유저에게 알림
        Get.snackbar(
          '',
          '',
          titleText: Text(
            '인증코드 입력 오류',
            style: AppTextStyle.snackbarTitleStyle,
          ),
          messageText: Text(
            '입력한 인증 코드를 확인해주세요.',
            style: AppTextStyle.snackbarContentStyle,
          ),
        );
      } else
        debugPrint(e.toString());
    }
  }
}
