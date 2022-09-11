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

  /* 게임모드가 
  * 솔로,자유 ? 포지션, 티어 둘다 표시 
  * 일반 ? 포지션만 표시 
  * 칼바람, AI ? null 
  */
  showPositonAndTear(modeValue) {
    selectedModeValue = modeValue;
    /* 솔로랭크, 자유랭크 */
    if (selectedModeValue == gameModes[1] ||
        selectedModeValue == gameModes[2]) {
      showPosition = true;
      showTear = true;
      update();
      /* 일반게임 */
    } else if (selectedModeValue == gameModes[3]) {
      showPosition = true;
      showTear = false;
      update();
      /* 칼바람, AI대전 */
    } else {
      showPosition = false;
      showTear = false;
      update();
    }
  }

  void changePosition(value) {
    selectedPositionValue = value;
    update();
  }

  void changeTear(value) {
    selectedTearValue = value;
    update();
  }
}
