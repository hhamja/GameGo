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
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    print(user?.uid);
  }

  /* 로그아웃 
  * Db,Auth정보 삭제 X  | 탈회하기랑은 다르게  자동로그인 쿠키만 앱에서 지움 */
  Future signOut() async {
    await _auth.signOut();
    print('로그아웃');
  }

  /* 탈퇴하기
  * DB, Auth정보 삭제O | mainLogoPage()로 이동 */
  Future deleteUser(smsCode) async {
    //입력한 sms코드를 잘못 입력한 경우에는 delete 안되게 해야하는데
    //어떻게 하지? -> test 주석 참고
    /////////////////////////////////////////////////////////////////////

    // final credential = await PhoneAuthProvider.credential(
    //     verificationId: verificationID, smsCode: smsCode);
    // print(credential);
    // //test
    // credential.smsCode != smsCode
    //     ? () => print('코드가 틀리잖아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ')
    //     : () => print('smsCode가 맞음 맞음 맞음 맞음맞음맞음맞음맞음맞음');
    // //test

    // //1. 사용자 재인증, 그래야 Auth에서 유저 삭제가능
    // await _auth.currentUser!.reauthenticateWithCredential(credential);

    //3. post에서 해당 유저가 작성한 게시글 삭제
    await _userDB.doc(CurrentUser.uid).collection('post').get().then(
      (value) {
        //내가 만든 게시글 id를 담을 빈 리스트
        var _postIdList = [];
        //게시글 id 리스트 넣기
        _postIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //받은 postId 리스트 반복문 -> 게시글 전부 삭제
        _postIdList.forEach(
          (postId) {
            _firestore.collection('post').doc(postId.toString()).delete().then(
                  (_) => print('나의 모든 게시글 삭제 완료'),
                );
          },
        );
      },
    );
    //4. postingUser로 참여한 채팅 데이터 수정
    //List postingUser로 = ['', 기본프로필 url, '(탈퇴유저)']
    await _userDB
        .doc(CurrentUser.uid)
        .collection('chat')
        .doc('chat')
        .collection('isPostingUser')
        .get()
        .then(
      (value) {
        //내가 postingUser로 있는 채팅방의 id 리스트
        var _chatIdList = [];
        //isPostingUser에서 id 리스트 담기
        _chatIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //받은 채팅방 Id 리스트 반복문 후 postingUser 업데이트
        _chatIdList.forEach(
          (chatId) {
            _firestore.collection('chat').doc(chatId.toString()).update(
              {
                'postingUser.${0}': '',
                'postingUser.${1}': DefaultProfle.url,
                'postingUser.${2}': '(탈퇴유저)',
              },
            ).then(
              (_) => print('내가 속한 채팅 데이터 처리 완료'),
            );
          },
        );
      },
    );
    //5. contactUser로 참여한 채팅 데이터 수정
    //List contactUser = ['', 기본프로필 url, '(탈퇴유저)']
    await _userDB
        .doc(CurrentUser.uid)
        .collection('chat')
        .doc('chat')
        .collection('isContactUser')
        .get()
        .then(
      (value) {
        //내가 postingUser로 있는 채팅방의 id 리스트
        var _chatIdList = [];
        //isPostingUser에서 id 리스트 담기
        _chatIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //받은 채팅방 Id 리스트 반복문 후  postingUser 업데이트
        _chatIdList.forEach(
          (chatId) {
            _firestore.collection('chat').doc(chatId.toString()).update(
              {
                'contactUser.${0}': '',
                'contactUser.${1}': DefaultProfle.url,
                'contactUser.${2}': '(탈퇴유저)',
              },
            ).then(
              (_) => print('내가 속한 채팅 데이터 처리 완료'),
            );
          },
        );
      },
    );
    // await _userDB.doc(CurrentUser.uid).collection('chat');
    // _firestore.collection('chat');
    // _firestore.collection('notification');
    //
    // //5. notifiacation 컬렉션에서 삭제

    //  //6. Auth 정보 삭제
    // await _auth.currentUser!.delete();
    // //7. user 컬렉션에서 삭제
    // _userDB.doc(CurrentUser.uid).delete();
    print('탈퇴하기');
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
