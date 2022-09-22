import 'package:mannergamer/utilites/index.dart';

class PhoneSMSController extends GetxController {
  static PhoneSMSController get to => Get.find<PhoneSMSController>();
  /* OTP 처음 받는 경우 : false
  * 두번 째   true로 됨. */
  bool isSendSms = false;

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
    isSendSms = true;
    update();
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
    update();
  }

  // Step 6
  void setCountDown() {
    update();
    final reduceSeconds = 1;
    update();
    final seconds = myDuration.inSeconds - reduceSeconds;
    update();
    if (seconds < 0) {
      update();
      countdownTimer!.cancel();
      update();
    } else {
      update();
      myDuration = Duration(seconds: seconds);
      update();
    }
    update();
  }
}
