import 'package:gamegoapp/utilites/index/index.dart';

class MyProfileController extends GetxController
    with StateMixin<Rx<UserModel>> {
  static UserController get to => Get.find<UserController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    final WriteBatch _batch = FirebaseFirestore.instance.batch();
    // 탈퇴 플래그 처리한 유저 닉네임도 고려할 것이므로 플래그 쿼리 X
    final snapshot = await _userDB.where('userName', isEqualTo: userName).get();
    // 닉네임 중복확인
    if (snapshot.docs.isEmpty) {
      // 중복 닉네임 없는 경우
      final QuerySnapshot chatSnapshot = await _chatDB
          .where('members', arrayContains: _auth.currentUser!.uid)
          .get();
      final QuerySnapshot postSnapshot = await _postDB
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .where('isDeleted', isEqualTo: false)
          .get();
      final QuerySnapshot reviewSnapshot = await _reviewDB
          .where('idFrom', isEqualTo: _auth.currentUser!.uid)
          .get();
      final QuerySnapshot ntfSnapshot = await _firestore
          .collection('notification')
          .where('idFrom', isEqualTo: _auth.currentUser!.uid)
          .get();
      // 유저 DB에서 닉네임 수정
      _batch.update(
        _userDB.doc(_auth.currentUser!.uid),
        {
          'userName': userName,
          'updatedAt': Timestamp.now(),
        },
      );
      // 채팅에서 닉네임 수정
      chatSnapshot.docs.forEach(
        (doc) {
          var docData = doc.data() as Map<String, dynamic>;
          // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
          bool isMyPost = docData['postingUid'] == _auth.currentUser!.uid;
          // 내가 postingUser인지 contactUser인지 확인
          if (isMyPost) {
            // postingUesr인 경우
            _batch.update(
              doc.reference,
              {'postingUserName': userName},
            );
          } else {
            // contactUser인 경우
            _batch.update(
              doc.reference,
              {'contactUserName': userName},
            );
          }
        },
      );
      // 게시글에서 닉네임 수정
      postSnapshot.docs.forEach(
        (doc) => _batch.update(
          doc.reference,
          {
            'userName': userName,
          },
        ),
      );
      // 게임후기의 닉네임 수정
      reviewSnapshot.docs.forEach(
        // 게임후기의 userName 수정
        (doc) => _batch.update(
          doc.reference,
          {
            'userName': userName,
          },
        ),
      );
      ntfSnapshot.docs.forEach(
        (doc) => _batch.update(
          doc.reference,
          {
            'userName': userName,
          },
        ),
      );
      // Auth 정보에서 닉네임 수정
      _auth.currentUser!.updateDisplayName(userName);
      await _batch.commit();
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
          '이미 존재하는 닉네임이에요.\n다른 닉네임으로 변경해주세요.',
          '확인',
          () => Get.back(),
        ),
      );
    }
  }

  // 나의 프로필을 변경하기
  Future updateUserProfile(profileUrl) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();
    final QuerySnapshot chatSnapshot = await _chatDB
        .where('members', arrayContains: _auth.currentUser!.uid)
        .get();
    final QuerySnapshot postSnapshot = await _postDB
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .where('isDeleted', isEqualTo: false)
        .get();
    final QuerySnapshot reviewSnapshot = await _reviewDB
        .where('idFrom', isEqualTo: _auth.currentUser!.uid)
        .get();
    // 유저정보에서 프로필 수정
    _batch.update(
      _userDB.doc(_auth.currentUser!.uid),
      {
        'profileUrl': profileUrl,
        'updatedAt': Timestamp.now(),
      },
    );
    // 채팅에서 닉네임 수정
    chatSnapshot.docs.forEach(
      (doc) {
        var docData = doc.data() as Map<String, dynamic>;
        // 내가 postingUer로 참여한 채팅방인지 여부를 나타내는 변수
        bool isMyPost = docData['postingUid'] == _auth.currentUser!.uid;
        // 내가 postingUser인지 contactUser인지 확인
        if (isMyPost) {
          // postingUesr인 경우
          _batch.update(
            doc.reference,
            {'postingUserProfileUrl': profileUrl},
          );
        } else {
          // contactUser인 경우
          _batch.update(
            doc.reference,
            {'contactUserProfileUrl': profileUrl},
          );
        }
      },
    );
    // 게시글에서 닉네임 수정
    postSnapshot.docs.forEach(
      (doc) => _batch.update(
        doc.reference,
        {
          'profileUrl': profileUrl,
        },
      ),
    );
    // 게임후기의 닉네임 수정
    reviewSnapshot.docs.forEach(
      // 게임후기의 userName 수정
      (doc) => _batch.update(
        doc.reference,
        {
          'profileUrl': profileUrl,
        },
      ),
    );
    // Auth의 프로필 수정
    _auth.currentUser!.updatePhotoURL(profileUrl);
    await _batch.commit();
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
