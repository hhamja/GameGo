import 'package:mannergamer/utilites/index/index.dart';

class SmsTimerController extends GetxController {
  static SmsTimerController get to => Get.find<SmsTimerController>();

  var count = 120; //파이어베이스에서 지원하는 SMS 최대 시간이 120초
  late Timer _timer;

  // sms 보내기 버튼 클릭 시 120초 카운트 다운 시작
  void StateTimerStart() {
    //타이머가 0이 될 때까지 1초 마다 -1
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
        update();
      } else {
        _timer.cancel();
        update();
      }
    });
    update();
  }

  // 카운터를 120초로 리셋하기
  void reset() {
    _timer.cancel();
    count = 120;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
        update();
      } else {
        _timer.cancel();
        update();
      }
    });
    update();
  }
}
