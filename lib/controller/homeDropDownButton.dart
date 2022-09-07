import 'package:mannergamer/utilites/index.dart';

/*-------------------- 홈페이지의 드랍다운버튼 컨트롤러 --------------------*/
class HomePageDropDownBTController extends GetxController {
  /* 포지션 드랍다운 버튼 보여주는 bool값 */
  bool showPosition = false;
  /* 티어 드랍다운 버튼 보여주는 bool값  */
  bool showTear = false;

  /* 게임모드 선택 value */
  var selectedModeValue;
  /* 포지션 선택 value */
  var selectedPositionValue;
  /* 티어 선택 value */
  var selectedTearValue;

  /* 게임모드가 
  * 솔로,자유 ? 포지션, 티어 둘다 표시 
  * 일반 ? 포지션만 표시 
  * 칼바람, AI ? null 
  */
  showPositonAndTear(modeValue) {
    selectedModeValue = modeValue as String;
    if (selectedModeValue == '솔로랭크' || selectedModeValue == '자유랭크') {
      showPosition = true;
      showTear = true;
      update();
    } else if (selectedModeValue == '일반게임') {
      showPosition = true;
      showTear = false;
      update();
    } else {
      showPosition = false;
      showTear = false;
      update();
    }
    update();
  }
}
