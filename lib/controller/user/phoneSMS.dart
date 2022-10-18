import 'package:mannergamer/utilites/index/index.dart';

class PhoneSMSController extends GetxController {
  static PhoneSMSController get to => Get.find<PhoneSMSController>();

  /* Life Cycle */
  @override
  void onInit() {
    super.onInit();
  }

  // Initial Count Timer value
  var count = 120;

  //object for Timer Class
  late Timer _timer;
  // a Method to start the Count Down
  void StateTimerStart() {
    //Timer Loop will execute every 1 second, until it reach 0
    // once counter value become 0, we store the timer using _timer.cancel()

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

  // reset count value to 10
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
