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
        'noticePushNtf': userModel.noticePushNtf,
        'marketingConsent': userModel.marketingConsent,
      },
    );
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
      null;
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
      // 1. 사용자 재인증, 그래야 Auth에서 유저 삭제가능
      await _auth.currentUser!.reauthenticateWithCredential(credential);

      //2. 해당 유저가 작성한 게시글의 프로필, 이름 수정
      await _userDB.doc(CurrentUser.uid).collection('post').get().then(
        (value) {
          //2-1. 내가 만든 게시글 id를 담을 빈 리스트
          var _postIdList = [];
          //2-2. 게시글 id 리스트 넣기
          _postIdList.assignAll(
            value.docs.map(
              (e) => e.reference.id,
            ),
          );
          //2-3. 받은 postId 리스트 반복문 -> 게시글 업데이트
          _postIdList.forEach(
            (postId) {
              _firestore.collection('post').doc(postId.toString()).update(
                {
                  'profileUrl': DefaultProfle.url, //기본프로필로 변경
                  'userName': CurrentUser.name + ' (탈퇴)', // 이름 뒤에 + (탈퇴)
                },
              ).then(
                (_) => print('나의 모든 게시글 프로필, 이름 업데이트'),
              );
            },
          );
        },
      );
      //3. postingUser로 참여한 채팅의 프로필, 이름 수정
      await _userDB
          .doc(CurrentUser.uid)
          .collection('chat')
          .doc('chat')
          .collection('isPostingUser')
          .get()
          .then(
        (value) {
          //3-1. 내가 postingUser로 있는 채팅방의 id 리스트
          var _chatIdList = [];
          //3-2. isPostingUser에서 id 리스트 담기
          _chatIdList.assignAll(
            value.docs.map(
              (e) => e.reference.id,
            ),
          );
          //3-3. 받은 채팅방 Id 리스트 반복문 -> postingUser 프로필, 이름 수정
          _chatIdList.forEach(
            (chatId) {
              _firestore.collection('chat').doc(chatId.toString()).update(
                {
                  'postingUserProfileUrl': DefaultProfle.url, //기본프로필로
                  'postingUserName': CurrentUser.name + ' (탈퇴)', //이름 +(탈퇴)
                },
              ).then(
                (_) => print('postingUser의 프로필, 이름 수정'),
              );
            },
          );
        },
      );
      //4. contactUser로 참여한 채팅의 프로필, 이름 수정
      await _userDB
          .doc(CurrentUser.uid)
          .collection('chat')
          .doc('chat')
          .collection('isContactUser')
          .get()
          .then(
        (value) {
          //4-1. 내가 contactUser 있는 채팅방의 id 리스트
          var _chatIdList = [];
          //4-2. isContactUser에서 id 리스트 담기
          _chatIdList.assignAll(
            value.docs.map(
              (e) => e.reference.id,
            ),
          );
          //4-3. 받은 채팅방 Id 리스트 반복문 -> contactUser의 프로필, 이름 수정
          _chatIdList.forEach(
            (chatId) {
              _firestore.collection('chat').doc(chatId.toString()).update(
                {
                  'contactUserProfileUrl': DefaultProfle.url, //기본프로필
                  'contactUserName': CurrentUser.name + ' (탈퇴)', //이름 (탈퇴)
                },
              ).then(
                (_) => print('contactUse의 프로필, 이름 수정'),
              );
            },
          );
        },
      );
      //5. 내가 보낸 notifiacation 수정
      //6. 내가 받은 게임 후기 삭제
      await _firestore
          .collection('gameReview')
          .doc(CurrentUser.uid)
          .delete()
          .then(
            (_) => print('내가 받은 게임후기 삭제 완료'),
          );
      //7. Auth 정보 삭제
      // await _auth.currentUser!.delete();
      //8. user 컬렉션에서 삭제
      // _userDB.doc(CurrentUser.uid).delete();

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
