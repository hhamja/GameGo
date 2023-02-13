import 'package:mannergamer/utilites/index/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _reviewDB =
      FirebaseFirestore.instance.collection('gameReview');

  // 유저리스트
  RxList<UserModel> userList = <UserModel>[].obs;
  // 특정 한명의 유저 정보
  Rx<UserModel> userInfo = UserModel(
    uid: '',
    userName: '',
    phoneNumber: '',
    profileUrl: '',
    mannerAge: 20,
    chatPushNtf: false,
    activityPushNtf: false,
    marketingConsent: false,
    nightPushNtf: false,
    isWithdrawn: false,
    updatedAt: Timestamp.now(),
    createdAt: Timestamp.now(),
  ).obs;
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
        'mannerAge': userModel.mannerAge,
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

  // 유저가 닉네임 변경
  Future updateUserName(userName) async {
    // 닉네임 중복확인
    // 탈퇴 플래그 처리한 유저 닉네임도 고려할 것이므로 플래그 쿼리 X
    await _userDB.where('userName', isEqualTo: userName).get().then(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          // Auth 정보에서 닉네임 수정
          _auth.currentUser!.updateDisplayName(userName);
          // 중복 닉네임 없는 경우
          _userDB.doc(_auth.currentUser!.uid).update(
            // 유저 DB에서 닉네임 수정
            {
              'userName': userName,
              'updatedAt': Timestamp.now(),
            },
          );
          // 채팅에서 닉네임 수정
          _chatDB
              .where('members', arrayContains: _auth.currentUser!.uid)
              .get()
              .then(
            // 내가 맴버로 있는 채팅방만 쿼리하여 리스트로 받기
            (value) {
              // 문서리스트 반복문
              value.docs.forEach(
                (e) {
                  // 데이터 Map 자료 형태로 변환
                  var snapshot = e.data() as Map<String, dynamic>;
                  // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
                  bool isMyPost =
                      snapshot['postingUid'] == _auth.currentUser!.uid;
                  // 채팅방 id 값
                  String chatRoomId = snapshot['chatRoomId'];
                  print(isMyPost);
                  print(chatRoomId);
                  // 내가 postingUser인지 contactUser인지 확인
                  if (isMyPost) {
                    // postingUesr인 경우
                    _chatDB.doc(chatRoomId).update(
                      // postingUserName 수정
                      {'postingUserName': userName},
                    ).then(
                      (_) => print('postingUserName 수정'),
                    );
                  } else {
                    // contactUser인 경우
                    _chatDB.doc(chatRoomId).update(
                      // contactUserName 수정
                      {'contactUserName': userName},
                    ).then(
                      (_) => print('contactUserName 수정'),
                      onError: (e) => print(e),
                    );
                  }
                },
              );
            },
          );
          // 게시글에서 닉네임 수정
          _postDB
              .where('uid', isEqualTo: _auth.currentUser!.uid)
              .where('isDeleted', isEqualTo: false)
              .get()
              .then(
            // 삭제하지 않은 나의 게시글만 쿼리
            (value) {
              // 문서리스트 반복문
              value.docs.forEach(
                (e) {
                  // 데이터 Map 자료 형태로 변환
                  var snapshot = e.data() as Map<String, dynamic>;
                  // 게시글 id
                  final String postId = snapshot['postId'];
                  print(postId);
                  // 게시글의 userName 수정
                  _postDB.doc(postId).update(
                    {
                      'userName': userName,
                    },
                  ).then(
                    (_) => print('게시글 닉네임 수정'),
                    onError: (e) => print(e),
                  );
                },
              );
            },
          );
          // 게임후기의 닉네임 수정
          _reviewDB
              .where('idFrom', isEqualTo: _auth.currentUser!.uid)
              .get()
              .then(
            // 내가 보낸 게임후기만 쿼리하여 리스트로 받기
            (value) {
              // 문서리스트 반복문
              value.docs.forEach(
                (e) {
                  // 게임후기 id
                  final String reviewId = e.reference.id;
                  print(reviewId);
                  // 게임후기의 userName 수정
                  _reviewDB.doc(reviewId).update(
                    {
                      'userName': userName,
                    },
                  ).then(
                    (_) => print('내가 보낸 게임후기의 닉네임 수정'),
                    onError: (e) => print(e),
                  );
                },
              );
            },
          );
          // 알림의 닉네임 수정
          _firestore
              .collection('notification')
              .where('idFrom', isEqualTo: _auth.currentUser!.uid)
              .get()
              .then(
                // 내가 보낸 알림만 쿼리하여 리스트로 받기
                (value) => value.docs.forEach(
                  // 문서리스트 반복문
                  (e) {
                    // 알림의 문서 id
                    final ntfId = e.reference.id;
                    // 알림의 userName 수정
                    _firestore.collection('notification').doc(ntfId).update(
                      {
                        'userName': userName,
                      },
                    ).then(
                      (_) => print('내가 보낸 알림의 닉네임 수정'),
                      onError: (e) => print(e),
                    );
                  },
                ),
              );
          Get.back();
        } else {
          // 중복 닉네임인 경우
          // 유저에게 다이얼로그로 알림
          Get.dialog(
            CustomOneButtonDialog(
              '이미 존재하는 닉네임 입니다.\n다른 닉네임으로 변경해주세요.',
              '확인',
              () => Get.back(),
            ),
          );
        }
      },
    );
  }

  // 나의 프로필을 변경하기
  Future updateUserProfile(profileUrl) async {
    // 유저정보에서 프로필 수정
    _userDB.doc(_auth.currentUser!.uid).update(
      {
        'profileUrl': profileUrl,
        'updatedAt': Timestamp.now(),
      },
    );

    // 채팅에서 프로필 수정
    _chatDB.where('members', arrayContains: _auth.currentUser!.uid).get().then(
      // 내가 맴버로 있는 채팅방만 쿼리하여 리스트로 받기
      (value) {
        // 문서리스트 반복문
        value.docs.forEach(
          (e) {
            // 데이터 Map 자료 형태로 변환
            var snapshot = e.data() as Map<String, dynamic>;
            // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
            bool isMyPost = snapshot['postingUid'] == _auth.currentUser!.uid;
            // 채팅방 id 값
            final String chatRoomId = snapshot['chatRoomId'];
            print(isMyPost);
            print(chatRoomId);
            // 내가 postingUser인지 contactUser인지 확인
            if (isMyPost) {
              // postingUesr인 경우
              _chatDB.doc(chatRoomId).update(
                // postingUserProfileUrl 수정
                {'postingUserProfileUrl': profileUrl},
              ).then(
                (_) => print('postingUserProfileUrl 수정'),
                onError: (e) => print(e),
              );
            } else {
              // contactUser인 경우
              _chatDB.doc(chatRoomId).update(
                // contactUserProfileUrl 수정
                {'contactUserProfileUrl': profileUrl},
              ).then(
                (_) => print('contactUserProfileUrl 수정'),
                onError: (e) => print(e),
              );
            }
          },
        );
      },
    );

    // 게시글에서 프로필 수정
    _postDB
        .where('isDeleted', isEqualTo: false)
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then(
      // 삭제하지 않은 나의 게시글만 쿼리
      (value) {
        // 문서리스트 반복문
        value.docs.forEach(
          (e) {
            // 데이터 Map 자료 형태로 변환
            var snapshot = e.data() as Map<String, dynamic>;
            // 게시글 id
            final String postId = snapshot['postId'];
            print(postId);
            // profileUrl 수정
            _postDB.doc(postId).update(
              {
                'profileUrl': profileUrl,
              },
            ).then(
              (_) => print('게시글 프로필 수정'),
              onError: (e) => print(e),
            );
          },
        );
      },
    );

    // 게임후기의 프로필 수정
    _reviewDB.where('idFrom', isEqualTo: _auth.currentUser!.uid).get().then(
      // 내가 보낸 게임후기만 쿼리하여 리스트로 받기
      (value) {
        // 문서리스트 반복문
        value.docs.forEach(
          (e) {
            // 게임후기 id
            final String reviewId = e.reference.id;
            print(reviewId);
            // 게임후기의 userName 수정
            _reviewDB.doc(reviewId).update(
              {
                'profileUrl': profileUrl,
              },
            ).then(
              (_) => print('내가 보낸 게임후기의 닉네임 수정'),
              onError: (e) => print(e),
            );
          },
        );
      },
    );

    // Auth의 프로필 수정
    _auth.currentUser!.updatePhotoURL(profileUrl).then(
          //
          (_) => print('auth의 프로필 수정'),
          onError: (e) => print(e),
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
    try {
      final credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);

      // 게시글 플래그
      _postDB
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .where('isDeleted', isEqualTo: false)
          .where('isHidden', isEqualTo: false)
          .get()
          .then(
        // 삭제하지 않은 나의 게시글 쿼리
        (value) {
          // 문서리스트 반복문
          value.docs.forEach(
            (e) {
              // 데이터 Map 자료 형태로 변환
              var snapshot = e.data() as Map<String, dynamic>;
              // 게시글 id
              final String postId = snapshot['postId'];
              // 게시글 플래그 수정
              _postDB.doc(postId).update(
                {
                  'isHidden': true,
                },
              ).then(
                (_) => print('게시글 플래그 수정'),
                onError: (e) => print(e),
              );
            },
          );
        },
      );

      // 채팅 플래그
      _chatDB
          .where('members', arrayContains: _auth.currentUser!.uid)
          // 채팅방 나가기 플래그가 false로 되어있다는 쿼리 추가하기 > 나중에
          .where('isActive', isEqualTo: true)
          .get()
          .then(
        // 나가지 않고 활성화 된 나의 채팅방 쿼리
        (value) {
          // 문서리스트 반복문
          value.docs.forEach(
            (e) {
              // 데이터 Map 변환
              var snapshot = e.data() as Map<String, dynamic>;
              // 채팅방 id 값
              final String chatRoomId = snapshot['chatRoomId'];
              print(chatRoomId);
              // 탈퇴유저의 채팅방 플래그 처리
              _chatDB.doc(chatRoomId).update(
                {
                  'isActive': false,
                },
              );
            },
          );
          print('채팅 플래그 처리 완료');
        },
        onError: (e) => print(e),
      );

      // 게임후기 기본 프로필로 수정
      _reviewDB.where('idFrom', isEqualTo: _auth.currentUser!.uid).get().then(
        // 내가 보낸 게임후기만 쿼리하여 리스트로 받기
        (value) {
          // 문서리스트 반복문
          value.docs.forEach(
            (e) {
              // 게임후기 id
              final String reviewId = e.reference.id;
              print(reviewId);
              // 게임후기의 프로필 수정
              _reviewDB.doc(reviewId).update(
                {
                  'profileUrl': DefaultProfle.url,
                },
              ).then(
                (_) => print('게임후기 기본 프로필로 수정'),
                onError: (e) => print(e),
              );
            },
          );
        },
      );

      // 유저정보 처리
      // 탈퇴 플래그 true, 탈퇴 시간 업데이트
      _userDB.doc(_auth.currentUser!.uid).update(
        {
          'isWithdrawn': true,
          'withdrawnAt': Timestamp.now(),
        },
      ).then(
        (_) => print('유저정보 플래그'),
        onError: (e) => print(e),
      );

      // Storage에서 해당 유저의 프로필 삭제
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

  // uid를 통해 특정 유저의 정보 받기
  Future getUserInfoByUid(uid) async {
    await _userDB.doc(uid).get().then(
          (value) => userInfo.value = UserModel.fromDocumentSnapshot(value),
        );
  }
}
