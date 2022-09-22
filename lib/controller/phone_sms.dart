import 'package:mannergamer/utilites/index.dart';

class PhoneSMSController extends GetxController {
  static PhoneSMSController get to => Get.find<PhoneSMSController>();

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 2);

  /* Life Cycle */
  @override
  void onInit() {
    super.onInit();
  }

  void firstClickButton() {
    //타이머 시작
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    //SMS입력칸, 시작하기, 개인정보취급방침 UI 표시
  }

  /* SMS 2분 타이머 시작 */
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  /* 재전송 버튼 다시 클릭 시 */
  void clickButtonAfterFirst() {
    countdownTimer!.cancel();
    myDuration = Duration(minutes: 2);
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 6
  void setCountDown() {
    final reduceSeconds = 1;
    final seconds = myDuration.inSeconds - reduceSeconds;

    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
  }
}
