import 'package:mannergamer/utilites/index/index.dart';

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

  // 폰번호확인코드저장
  String verificationID = '';
  int? _resendToken;

  // 유저 생성하기
  Future addNewUser(UserModel userModel) async {
    await _userDB.doc(userModel.uid).set(
      {
        'uid': userModel.uid,
        'userName': userModel.userName,
        'profileUrl': userModel.profileUrl,
        'mannerLevel': userModel.mannerLevel,
        'phoneNumber': userModel.phoneNumber,
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

  // 폰으로 SMS 전송
  Future verifyPhone(String phonenumber) async {
    return _auth.verifyPhoneNumber(
      // 폰번호
      phoneNumber: phonenumber,
      // 인증 성공시
      verificationCompleted: (PhoneAuthCredential credential) {},
      // 잘못된 전화번호 또는 SMS 할당량 초과 여부 등과 같은 인증실패 시
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar(
            '',
            '',
            titleText: Text(
              '인증실패',
              style: AppTextStyle.snackbarTitleStyle,
            ),
            messageText: Text(
              '잘못된 휴대폰 번호입니다.',
              style: AppTextStyle.snackbarContentStyle,
            ),
          );
          print('The provided phone number is not valid.');
        } else {
          Get.snackbar(
            '',
            '',
            titleText: Text(
              '인증실패',
              style: AppTextStyle.snackbarTitleStyle,
            ),
            messageText: Text(
              '잠시 후 다시 시도해주세요.',
              style: AppTextStyle.snackbarContentStyle,
            ),
          );
        }
      },
      // 기기로 코드 전송 시 처리
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        // 120초안에 재전송시 토큰
        _resendToken = resendToken;
      },
      // 자동 SMS 코드 처리가 실패할 때의 시간 초과를 처리
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: _resendToken, //sms 재전송 시의 토큰
      timeout: const Duration(seconds: 120),
    );
  }

  // 휴대폰 번호로 신규 가입하기
  Future signUP(token) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: token);
      _auth.signInWithCredential(credential);
      print('signUp successful');
    } on FirebaseAuthException catch (e) {
      // 에러 코드
      if (e.code == 'invalid-verification-code') {
        // SMS 입력이 틀린 경우
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
      }
      print(e.code);
    }
  }

  // 로그아웃
  Future signOut() async {
    // 로그아웃시 푸시알림 수신 못하게 하기 위해 토큰값 null로 업데이트
    await _userDB.doc(_auth.currentUser!.uid).update(
      {
        'pushToken': null,
      },
    );
    // 유저정보 토큰값을 앱 로컬에서 지우기
    _auth.signOut();
  }

  // 탈퇴하기
  Future deleteUser(smsCode) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();
    try {
      final credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);

      // 게시글 플래그
      _postDB
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          // 삭제하지 않은 나의 게시글 쿼리
          .where('isDeleted', isEqualTo: false)
          .where('isHidden', isEqualTo: false)
          .get()
          .then(
        (value) {
          value.docs.forEach(
            (e) {
              var snapshot = e.data() as Map<String, dynamic>;
              final String postId = snapshot['postId'];
              // 게시글 플래그 수정
              _batch.update(
                _postDB.doc(postId),
                {'isHidden': true},
              );
            },
          );
        },
      );

      // 채팅 플래그
      _chatDB
          .where('members', arrayContains: _auth.currentUser!.uid)
          // 채팅방 나가기 플래그가 false로 되어있다는 쿼리 추가하기 > 나중에
          // 나가지 않고 활성화 된 나의 채팅방 쿼리
          .where('isActive', isEqualTo: true)
          .get()
          .then(
        (value) {
          value.docs.forEach(
            (e) {
              var snapshot = e.data() as Map<String, dynamic>;
              final String chatRoomId = snapshot['chatRoomId'];
              // 탈퇴유저의 채팅방 플래그 처리
              _batch.update(
                _chatDB.doc(chatRoomId),
                {'isActive': false},
              );
            },
          );
        },
        onError: (e) => print(e),
      );

      // 게임후기 기본 프로필로 수정
      _reviewDB.where('idFrom', isEqualTo: _auth.currentUser!.uid).get().then(
        // 내가 보낸 게임후기만 쿼리하여 리스트로 받기
        (value) {
          value.docs.forEach(
            (e) {
              final String reviewId = e.reference.id;
              // 게임후기의 프로필 수정
              _batch.update(
                _reviewDB.doc(reviewId),
                {'profileUrl': DefaultProfle.url},
              );
            },
          );
        },
      );
      // 유저정보 처리
      // 탈퇴 플래그 true, 탈퇴 시간 업데이트
      _batch.update(
        _userDB.doc(_auth.currentUser!.uid),
        {
          'isWithdrawn': true,
          'withdrawnAt': Timestamp.now(),
        },
      );
      _batch.commit();
      // // Storage에서 해당 유저의 프로필 삭제
      // FirebaseStorage.instance.ref().child(CurrentUser.uid).delete();
      // 사용자 재인증
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      // 장치에 저장된 유저 토큰 삭제
      _auth.currentUser!.delete();
      print('탈퇴 성공');
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
        print(e);
    }
  }
}
