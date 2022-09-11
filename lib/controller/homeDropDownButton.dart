import 'dart:html';

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

  PostController _postController = Get.put(PostController());
  /* 게임모드가 
  * 솔로,자유 ? 포지션, 티어 둘다 표시 
  * 일반 ? 포지션만 표시 
  * 칼바람, AI ? null 
  */
  showPositonAndTear(modeValue) {
    selectedModeValue = modeValue as String;
    update();
    filter(_gamemode) {
      _postController.postList.bindStream(_postController.gamemode(_gamemode));
    }

    /* 솔로랭크, 자유랭크 */
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
}
