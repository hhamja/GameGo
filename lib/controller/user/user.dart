import 'package:mannergamer/utilites/index/index.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  /* 유저리스트 */
  RxList<UserModel> userList = <UserModel>[].obs;
  /* 특정 한명의 유저 정보 */
  RxMap<String, dynamic> userInfo = Map<String, dynamic>().obs;
  /* 폰번호확인코드저장 */
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
    //기존 닉네임이랑 변경 된 경우 닉네임 수정
    //이 조건식은 함수 선언하는 view에서 하자

    //닉네임에 대한 중복확인
    await _userDB.where('userName', isEqualTo: userName).get().then(
      (snapshot) {
        //1. 중복 닉네임 X
        if (snapshot.docs.isEmpty) {
          //1-1. 유저 DB
          _userDB.doc(CurrentUser.uid).update(
            {'userName': userName},
          );
          //1-2. 채팅
          _userDB.doc(CurrentUser.uid).collection('chat').get().then(
            (value) {
              value.docs.forEach(
                (e) {
                  var snapshot = e.data();
                  var isMyPost =
                      snapshot['isMyPost']; //해당 채팅방이 내가 postingUser인지
                  final String chatRoomId = e.reference.id; //채팅방 id 값
                  print(isMyPost);
                  print(chatRoomId);
                  //1-1-1. postingUesr인 채팅인 경우
                  if (isMyPost) {
                    //chatRoomId를 넣어 프로필, 닉네임 수정
                    _firestore.collection('chat').doc(chatRoomId).update(
                      {
                        'postingUserName': userName,
                      },
                    ).then(
                      (_) => print('postingUser 닉네임 수정'),
                    );
                  }
                  //1-1-2. contactUser인 채팅인 경우
                  else {
                    //chatRoomId를 넣어 프로필, 닉네임 수정
                    _firestore.collection('chat').doc(chatRoomId).update(
                      {
                        'contactUserName': userName,
                      },
                    ).then(
                      (_) => print('contactUser 닉네임 수정'),
                    );
                  }
                },
              );
            },
          );
          //1-3. 게시글
          _userDB.doc(CurrentUser.uid).collection('post').get().then(
            (value) {
              //내가 만든 게시글 id를 담을 빈 리스트
              var _postIdList = [];
              //게시글 id 리스트 넣기
              _postIdList.assignAll(
                value.docs.map(
                  (e) => e.reference.id,
                ),
              );
              //받은 postId 리스트 반복문 -> 게시글 업데이트
              _postIdList.forEach(
                (postId) {
                  _firestore.collection('post').doc(postId.toString()).update(
                    {
                      'userName': userName,
                    },
                  ).then(
                    (_) => print('나의 모든 게시글 닉네임 업데이트'),
                  );
                },
              );
            },
          );
          //1-4. 내가 보낸 게임 후기
          _userDB.doc(CurrentUser.uid).collection('sentGameReview').get().then(
            (value) {
              //내가 보낸 게임 후기 id 담을 리스트
              var _idList = [];
              //게임 후기 id 리스트 넣기
              _idList.assignAll(
                value.docs.map(
                  (e) => e.reference.id,
                ),
              );
              //id 리스트 반복문 -> 게임후기 업데이트
              _idList.forEach(
                (id) {
                  _firestore.collection('gameReview').doc(id).update(
                    {
                      'userName': userName,
                    },
                  ).then(
                    (_) => print('내가 보낸 게임 후기 닉네임 업데이트'),
                  );
                },
              );
            },
          );
          //1-5. Notification
          _firestore
              .collection('notification')
              .where('idFrom', isEqualTo: CurrentUser.uid) //내가 보낸 ntf
              .get()
              .then(
                (value) => value.docs.forEach(
                  (e) {
                    final _id = e.reference.id;
                    _firestore.collection('notification').doc(_id).update(
                      {
                        'userName': userName,
                      },
                    );
                  },
                ),
              );
          //1-6. Auth 정보
          _auth.currentUser!.updateDisplayName(userName);
        }
        //2. 중복 닉네임 O
        else {
          Get.snackbar('중복 닉네임', '해당 닉네임은 사용할 수 없습니다.');
        }
      },
    );
  }

  /* 유저가 프로필 수정 */
  // 관심게시글의 
  Future updateUserProfile(profileUrl) async {
    //기존 프로필에서 변경 된 경우 프로필 수정
    //이 조건문은 view로 옮기지 굳이 함수실행까지 할 필요가 없다.

    //1. 유저정보
    _userDB.doc(CurrentUser.uid).update(
      {
        'profileUrl': profileUrl,
      },
    );
    //2. 채팅
    _userDB.doc(CurrentUser.uid).collection('chat').get().then(
      (value) {
        value.docs.forEach(
          (e) {
            var snapshot = e.data();
            var isMyPost = snapshot['isMyPost']; //해당 채팅방이 내가 postingUser인지
            final String chatRoomId = e.reference.id; //채팅방 id 값
            print(isMyPost);
            print(chatRoomId);
            //ㄱ. postingUesr인 채팅인 경우
            if (isMyPost) {
              //chatRoomId를 넣어 프로필, 닉네임 수정
              _firestore.collection('chat').doc(chatRoomId).update(
                {
                  'postingUserProfileUrl': profileUrl,
                },
              ).then(
                (_) => print('postingUser의 프로필, 이름 수정'),
              );
            }
            //ㄴ. contactUser인 채팅인 경우
            else {
              //chatRoomId를 넣어 프로필, 닉네임 수정
              _firestore.collection('chat').doc(chatRoomId).update(
                {
                  'contactUserProfileUrl': profileUrl,
                },
              ).then(
                (_) => print('contactUser 프로필, 이름 수정'),
              );
            }
          },
        );
      },
    );
    //3. 나의 게시글
    _userDB.doc(CurrentUser.uid).collection('post').get().then(
      (value) {
        //내가 만든 게시글 id를 담을 빈 리스트
        var _postIdList = [];
        //게시글 id 리스트 넣기
        _postIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //받은 postId 리스트 반복문 -> 게시글 업데이트
        _postIdList.forEach(
          (postId) {
            _firestore.collection('post').doc(postId.toString()).update(
              {
                'profileUrl': profileUrl,
              },
            ).then(
              (_) => print('나의 모든 게시글 프로필 업데이트'),
            );
          },
        );
      },
    );
    //4. 내가 보낸 게임 후기
    _userDB.doc(CurrentUser.uid).collection('sentGameReview').get().then(
      (value) {
        //내가 보낸 게임 후기 id 담을 리스트
        var _idList = [];
        //게임 후기 id 리스트 넣기
        _idList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //2-3. 받은 id 리스트 반복문 -> 게임후기 업데이트
        _idList.forEach(
          (id) {
            _firestore.collection('gameReview').doc(id).update(
              {
                'profileUrl': profileUrl,
              },
            ).then(
              (_) => print('내가 보낸 게임 후기 프로필 업데이트'),
            );
          },
        );
      },
    );
    //5. Auth 정보
    _auth.currentUser!.updatePhotoURL(profileUrl);
  }

  /* 폰으로 SMS 전송 */
  Future verifyPhone(String phonenumber) async {
    return _auth.verifyPhoneNumber(
      //폰번호
      phoneNumber: phonenumber,
      //인증성공시
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
      /* 기기로 코드 전송 시 처리 */
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        _resendToken = resendToken;
        //sms코드를 자동으로 입력하는 autoFill을 넣자.(나중)
      },
      /* 자동 SMS 코드 처리가 실패할 때의 시간 초과를 처리 */
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: _resendToken, //sms 재전송 시의 토큰
      timeout: const Duration(seconds: 120),
    );
  }

  /* 폰가입정보 SignUP */
  Future signUP(token) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: token);
    try {
      await _auth.signInWithCredential(credential);
      print('signUp successful');
    } on FirebaseAuthException catch (e) {
      //SMS 코드가 틀린 경우
      if (e.code == 'invalid-verification-code') {
        Get.snackbar('인증코드 입력 오류', '입력한 인증 코드를 확인해주세요.');
      }
      print(e.code);
    }
  }

  /* 로그아웃 
  * Db,Auth정보 삭제 X  | 탈회하기랑은 다르게  자동로그인 쿠키만 앱에서 지움 */
  Future signOut() async {
    await _auth.signOut();
    print('로그아웃');
  }

  /* 탈퇴하기
  * 1. 서버의 유저 정보(하위 컬렉션 전부)는 삭제 O
  * 2. 유저정보 외 채팅, 게시글 삭제X , 프로필, 이름 수정 , 게
  * 3. mainLogoPage()로 이동 */
  Future deleteUser(smsCode) async {
    try {
      final credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      // 1. Storage에서 해당 유저의 프로필 삭제
      FirebaseStorage.instance.ref().child(CurrentUser.uid).delete();
      // 2. user 컬렉션에서 삭제
      _userDB.doc(CurrentUser.uid).delete();
      // 3. 사용자 재인증, 그래야 Auth에서 유저 삭제가능
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      // 4. Auth 정보 삭제
      await _auth.currentUser!.delete();

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
    await _userDB.doc(uid).get().then(
      (value) {
        userInfo.value = value.data()! as Map<String, dynamic>;
        print(userInfo); //유저정보 프린트
      },
    );
  }
}
