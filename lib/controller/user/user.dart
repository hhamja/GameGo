import 'package:mannergamer/utilites/index/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  final _auth = FirebaseAuth.instance;
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
  RxMap<String, dynamic> userInfo = Map<String, dynamic>().obs;
  // 폰번호확인코드저장
  String verificationID = '';
  int? _resendToken;

  /* 유저 생성하기 */
  Future addNewUser(UserModel userModel) async {
    await _userDB.doc(userModel.uid).set(
      {
        'uid': userModel.uid,
        'userName': userModel.userName,
        'profileUrl': userModel.profileUrl,
        'mannerAge': userModel.mannerAge,
        'createdAt': userModel.createdAt,
        'phoneNumber': userModel.phoneNumber,
        'chatPushNtf': userModel.chatPushNtf,
        'activityPushNtf': userModel.activityPushNtf,
        'nightPushNtf': userModel.nightPushNtf,
        'marketingConsent': userModel.marketingConsent,
      },
    );
  }

  /* 유저가 닉네임 변경 */
  Future updateUserName(userName) async {
    // 닉네임 중복확인
    await _userDB.where('userName', isEqualTo: userName).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        // 중복 닉네임 없는 경우
        // 유저 DB에서 닉네임 수정
        _userDB.doc(CurrentUser.uid).update(
          {
            'userName': userName,
          },
        );
        // 채팅에서 닉네임 수정
        _chatDB.where('members', arrayContains: CurrentUser.uid).get().then(
          // 내가 맴버로 있는 채팅방만 쿼리하여 리스트로 받기
          (value) {
            // 문서리스트 반복문
            value.docs.forEach(
              (e) {
                // 데이터 Map 자료 형태로 변환
                var snapshot = e.data() as Map<String, dynamic>;
                // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
                bool isMyPost = snapshot['postingUid'] == CurrentUser.uid;
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
        _postDB.where('uid', isEqualTo: CurrentUser.uid).get().then(
          // 나의 게시글만 쿼리하여 리스트로 받기
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
        _reviewDB.where('idFrom', isEqualTo: CurrentUser.uid).get().then(
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
            .where('idFrom', isEqualTo: CurrentUser.uid)
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
        // Auth 정보에서 닉네임 수정
        _auth.currentUser!.updateDisplayName(userName).then(
              (_) => print('auth의 닉네임 수정'),
              onError: (e) => print(e),
            );
      } else {
        // 중복 닉네임인 경우
        // 유저에게 스낵바로 알림
        Get.snackbar('중복 닉네임', '해당 닉네임은 사용할 수 없습니다.');
      }
    });
  }

  /* 나의 프로필을 변경하기 */
  Future updateUserProfile(profileUrl) async {
    // 유저정보에서 프로필 수정
    _userDB.doc(CurrentUser.uid).update(
      {
        'profileUrl': profileUrl,
      },
    );
    // 채팅에서 프로필 수정
    _chatDB.where('members', arrayContains: CurrentUser.uid).get().then(
      // 내가 맴버로 있는 채팅방만 쿼리하여 리스트로 받기
      (value) {
        // 문서리스트 반복문
        value.docs.forEach(
          (e) {
            // 데이터 Map 자료 형태로 변환
            var snapshot = e.data() as Map<String, dynamic>;
            // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
            bool isMyPost = snapshot['postingUid'] == CurrentUser.uid;
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
    _postDB.where('uid', isEqualTo: CurrentUser.uid).get().then(
      // 나의 게시글만 쿼리하여 리스트로 받기
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
    _reviewDB.where('idFrom', isEqualTo: CurrentUser.uid).get().then(
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
          (_) => print('auth의 프로필 수정'),
          onError: (e) => print(e),
        );
  }

  /* 폰으로 SMS 전송 */
  Future verifyPhone(String phonenumber) async {
    return _auth.verifyPhoneNumber(
      //폰번호
      phoneNumber: phonenumber,
      //인증 성공시
      verificationCompleted: (PhoneAuthCredential credential) {},
      // 잘못된 전화번호 또는 SMS 할당량 초과 여부 등과 같은 인증실패 시
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar(
            '인증실패',
            '잘못된 휴대폰 번호입니다.',
          );
          print('The provided phone number is not valid.');
        } else {
          Get.snackbar(
            '인증실패',
            '잠시 후 다시 시도해주세요.',
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

  /* 휴대폰 번호로 신규 가입하기 */
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
        Get.snackbar('인증코드 입력 오류', '입력한 인증 코드를 확인해주세요.');
      }
      print(e.code);
    }
  }

  /* 로그아웃 
  * Db,Auth정보 삭제 X  | 탈회하기랑은 다르게  자동로그인 쿠키만 앱에서 지움 */
  Future signOut() async {
    _auth.signOut();
    print('로그아웃');
  }

  /* 탈퇴하기
  * 서버의 직접적인 유저정보 전부 삭제 (userDB, storage의 프로필 사진)
  * 채팅, 게시글, 관심게시글, 유저차단, 신고, 매너평가, 게임후기 등은 그대로 */
  Future deleteUser(smsCode) async {
    try {
      final credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      // 사용자 재인증, 그래야 Auth에서 유저 삭제가능
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      // Storage에서 해당 유저의 프로필 삭제
      FirebaseStorage.instance.ref().child(CurrentUser.uid).delete();
      // user 컬렉션에서 삭제
      _userDB.doc(CurrentUser.uid).delete();
      // Auth 정보 삭제
      _auth.currentUser!.delete();
      print('탈퇴 성공');
    } on FirebaseAuthException catch (e) {
      //SMS 코드가 틀린 경우
      if (e.code == 'invalid-verification-code') {
        Get.snackbar('인증코드 입력 오류', '입력한 인증 코드를 확인해주세요.');
      } else
        print(e);
    }
  }

  /* uid를 통해 특정 유저의 정보 받기 */
  Future getUserInfoByUid(uid) async {
    return _userDB.doc(uid).get().then(
      (value) {
        userInfo.value = value.data()! as Map<String, dynamic>;
        print(userInfo);
      },
    );
  }
}
