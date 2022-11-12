import 'package:mannergamer/utilites/index/index.dart';

/*------------------- 수정페이지 드랍다운버튼 컨트롤러 ----------------------*/

class EditDropDownController extends GetxController {
  /* 포지션 · 티어의 드랍다운버튼 보여주는 bool 값 */
  bool showPosition = true;
  bool showTear = true;
  /* 드랍다운버튼 선택 값을 담는 변수 */
  var seledtedPostGamemodeValue;
  var seledtedPostdPositionValue;
  var seledtedPostTearValue;
  /* Post detail Page에서 게임모드, 포지션, 티어 값 전달 받음 */
  final gamemode = Get.arguments['gamemode'];
  final position = Get.arguments['position'];
  final tear = Get.arguments['tear'];

  /* 드랍다운버튼 선택 값 = Get.Argument로 전달한 값 */
  @override
  void onInit() {
    super.onInit();
    seledtedPostGamemodeValue = Get.arguments['gamemode'];
    seledtedPostdPositionValue = Get.arguments['position'];
    seledtedPostTearValue = Get.arguments['tear'];
  }

  /* 게임모드가 
  * 솔로,자유 ? 포지션, 티어 둘다 표시 
  * 일반 ? 포지션만 표시 
  * 칼바람, AI ? null 
  
  ps. createPage와 달리 EditPage에서는 기존의 선택한 데이터도 불러와야하므로 
  showdropDownPosition(), showdropDownTears()를 추가하여 
  */
  bool showdropDownPosition() {
    if (seledtedPostGamemodeValue == '솔로랭크' ||
        seledtedPostGamemodeValue == '자유랭크') {
      update();
      return true;
    } else if (seledtedPostGamemodeValue == '일반게임') {
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  bool showdropDownTears() {
    if (seledtedPostGamemodeValue == '솔로랭크' ||
        seledtedPostGamemodeValue == '자유랭크') {
      update();
      return true;
    } else if (seledtedPostGamemodeValue == '일반게임') {
      update();
      return false;
    } else {
      update();
      return false;
    }
  }

  showPositonAndTear(modeValue) {
    /* 다시 게임모드버튼 클릭 -> 포지션, 티어 값 초기화 */
    seledtedPostdPositionValue = null;
    seledtedPostTearValue = null;

    seledtedPostGamemodeValue = modeValue as String;
    if (seledtedPostGamemodeValue == '솔로랭크' ||
        seledtedPostGamemodeValue == '자유랭크') {
      showdropDownPosition;
      showdropDownTears;
      update();
    } else if (seledtedPostGamemodeValue == '일반게임') {
      showdropDownPosition;
      showdropDownTears;
      update();
    } else {
      showdropDownPosition;
      showdropDownTears;
      update();
    }
    update();
  }
}
