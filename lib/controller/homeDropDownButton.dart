import 'package:mannergamer/utilites/index.dart';

/*-------------------- 홈페이지의 드랍다운버튼 컨트롤러 --------------------*/
class HomePageDropDownBTController extends GetxController {
  /* 포지션 드랍다운 버튼 보여주는 bool값 */
  bool showPosition = false;
  /* 티어 드랍다운 버튼 보여주는 bool값  */
  bool showTear = false;

  /* 게임모드 선택 value */
  var selectedModeValue = gameModes[0];
  /* 포지션 선택 value */
  var selectedPositionValue = postions[0];
  /* 티어 선택 value */
  var selectedTearValue = tears[0];

  /* PostController 선언 */
  PostController _postController = Get.put(PostController());

  /* 게임모드가 
  * 솔로,자유 ? 포지션, 티어 둘다 표시 
  * 일반 ? 포지션만 표시 
  * 칼바람, AI ? null 
  */
  changeGamemode(modeValue) {
    selectedModeValue = modeValue as String;
    update();
    filter(_gamemode) {
      _postController.postList
          .bindStream(_postController.filterGamemode(_gamemode));
    }

    /* 게임모드 switch - case */
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

  /* 포지션 드랍다운버튼 클릭 시 */
  changePosition(value) {
    selectedPositionValue = value as String;
    update();
    filter(gamemode, position) {
      _postController.postList
          .bindStream(_postController.filterPosition(gamemode, position));
    }

    /* 게임모드 switch - case */
    switch (selectedPositionValue) {
      case '포지션':
        filter(null, null);
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

  /* 티어 드랍다운버튼 클릭 시 */
  changeTear(value) {
    selectedTearValue = value as String;
    update();
    filter(gamemode, position, tear) {
      _postController.postList
          .bindStream(_postController.filterTear(gamemode, position, tear));
    }

    /* 게임모드 switch - case */
    switch (selectedTearValue) {
      case '티어':
        filter(null, null, null);
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
