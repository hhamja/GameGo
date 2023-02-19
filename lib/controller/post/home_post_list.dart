import 'package:gamego/utilites/index/index.dart';

class HomePostController extends GetxController
    with StateMixin<RxList<PostModel>> {
  static HomePostController get to => Get.find<HomePostController>();
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  RxList<PostModel> postList = <PostModel>[].obs;

  // 포지션 드랍다운 버튼 보여주는 bool값
  bool showPosition = false;
  // 티어 드랍다운 버튼 보여주는 bool값
  bool showTear = false;
  // 게임모드 선택 value, 초기값 = '게임모드'
  var selectedModeValue = homeGameModeList[0];
  // 포지션 선택 value, 초기값 = '포지션'
  var selectedPositionValue = homePostionList[0];
  // 티어 선택 value, 초기값 = '티어'
  var selectedTearValue = homeTearList[0];

  @override
  void onInit() {
    super.onInit();
    readPostData();
  }

  // 모든 게시물 리스트로 받기
  Future readPostData() async {
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    // 파이어스토어 DB에서 데이터 받기
    await _postDB
        .where('isDeleted', isEqualTo: false)
        .where('isHidden', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          onError: (err) => change(null,
              status: RxStatus.error(err.toString())), //데이터 받는 과정에서 에러나는 경우
        );
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      //데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      //리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  // 게시글을 게임모드 필터링하여 받기
  Future filterGamemode(gamemode) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    await _postDB
        .where('gamemode', isEqualTo: gamemode)
        .where('isDeleted', isEqualTo: false)
        .where('isHidden', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          // 데이터 받는 과정에서 에러나는 경우
          onError: (err) =>
              change(null, status: RxStatus.error(err.toString())),
        );
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      // 데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      // 리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  // 게시글을 게임모드, 포지션 필터링하여 받기
  Future filterPosition(gamemode, position) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    await _postDB
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('isDeleted', isEqualTo: false)
        .where('isHidden', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          // 데이터 받는 과정에서 에러나는 경우
          onError: (err) =>
              change(null, status: RxStatus.error(err.toString())),
        );
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      // 데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      // 리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  // 게시글을 게임모드, 포지션, 티어 필터링하여 받기
  Future filterTear(gamemode, position, tear) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    await _postDB
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .where('isDeleted', isEqualTo: false)
        .where('isHidden', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get()
        .then(
            (snapshot) => postList.assignAll(
                snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
            //데이터 받는 과정에서 에러나는 경우
            onError: (err) => change(
                  null,
                  status: RxStatus.error(err.toString()),
                ));
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      //데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      //리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  // 게임모드가
  // 솔로,자유 ? 포지션, 티어 둘다 표시
  // 일반 ? 포지션만 표시
  // 칼바람, AI ? null

  changeGamemode(modeValue) {
    selectedModeValue = modeValue as String;
    selectedPositionValue = '포지션';
    selectedTearValue = '티어';
    update();
    filter(_gamemode) {
      filterGamemode(_gamemode);
    }

    // 게임모드 switch - case
    switch (selectedModeValue) {
      case '게임모드':
        showPosition = false;
        showTear = false;
        filter(null);
        break;
      case '솔로랭크':
        showPosition = true;
        showTear = true;
        filter('솔로랭크');
        break;
      case '자유랭크':
        showPosition = true;
        showTear = true;
        filter('자유랭크');
        break;
      case '일반게임':
        showPosition = true;
        showTear = false;
        filter('일반게임');
        break;
      case '무작위 총력전':
        showPosition = false;
        showTear = false;
        filter('무작위 총력전');
        break;
      case 'AI 대전':
        showPosition = false;
        showTear = false;
        filter('AI 대전');
        break;
    }
  }

  // 포지션 드랍다운버튼 클릭 시
  changePosition(value) {
    selectedPositionValue = value as String;
    selectedTearValue = '티어';
    update();
    filter(gamemode, position) {
      filterPosition(gamemode, position);
    }

    // 게임모드 switch - case
    switch (selectedPositionValue) {
      case '포지션':
        filter(selectedModeValue, null);
        break;
      case '탑':
        filter(selectedModeValue, '탑');
        break;
      case '정글':
        filter(selectedModeValue, '정글');
        break;
      case '미드':
        filter(selectedModeValue, '미드');
        break;
      case '원딜':
        filter(selectedModeValue, '원딜');
        break;
      case '서포터':
        filter(selectedModeValue, '서포터');
        break;
    }
  }

  // 티어 드랍다운버튼 클릭 시
  changeTear(value) {
    selectedTearValue = value as String;
    update();
    filter(gamemode, position, tear) {
      filterTear(gamemode, position, tear);
    }

    // 게임모드 switch - case
    switch (selectedTearValue) {
      case '티어':
        filter(selectedModeValue, selectedPositionValue, null);
        break;
      case '언랭크':
        filter(selectedModeValue, selectedPositionValue, '언랭크');
        break;
      case '아이언':
        filter(selectedModeValue, selectedPositionValue, '아이언');
        break;
      case '브론즈':
        filter(selectedModeValue, selectedPositionValue, '브론즈');
        break;
      case '실버':
        filter(selectedModeValue, selectedPositionValue, '실버');
        break;
      case '골드':
        filter(selectedModeValue, selectedPositionValue, '골드');
        break;
      case '플래티넘':
        filter(selectedModeValue, selectedPositionValue, '플래티넘');
        break;
      case '다이아몬드':
        filter(selectedModeValue, selectedPositionValue, '다이아몬드');
        break;
    }
  }
}
