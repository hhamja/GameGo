import 'package:mannergamer/utilites/index/index.dart';

class MyProfileController extends GetxController
    with StateMixin<Rx<UserModel>> {
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

  Rx<UserModel> _userInfo = UserModel(
    uid: '',
    userName: '',
    phoneNumber: '',
    profileUrl: '',
    mannerLevel: 3000,
    chatPushNtf: false,
    activityPushNtf: false,
    marketingConsent: false,
    nightPushNtf: false,
    isWithdrawn: false,
    updatedAt: Timestamp.now(),
    createdAt: Timestamp.now(),
  ).obs;
  UserModel get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    getUserInfoByUid(_auth.currentUser!.uid);
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
          // 내정보 새로고침
          getUserInfoByUid(_auth.currentUser!.uid).then(
            // 내정보 페이지로 이동
            (_) => Get.back(),
          );
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

  // uid를 통해 특정 유저의 정보 받기
  Future getUserInfoByUid(uid) async {
    change(_userInfo, status: RxStatus.loading());
    await _userDB.doc(uid).get().then(
          (value) => _userInfo.value = UserModel.fromDocumentSnapshot(value),
        );
    // 데이터 상태
    if (_userInfo.value.uid == '') {
      // 빈 값인 경우
      change(_userInfo, status: RxStatus.empty());
    } else {
      // 값이 정상적으로 GET한 경우
      change(_userInfo, status: RxStatus.success());
    }
  }
}
