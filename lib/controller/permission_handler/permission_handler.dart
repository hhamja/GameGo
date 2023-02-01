import 'package:mannergamer/utilites/index/index.dart';

class PermissionHandler extends GetxController {
  //알림 권한 요청
  //회원가입 후 홈페이지 이동하기 전에 권한요청하기
  Future<bool> requestNotificationPermission() async {
    // 권한 요청
    PermissionStatus status = await Permission.notification.request();
    // 결과 확인
    if (status.isGranted) {
      // 승인된 경우
      return true;
    } else {
      // 거절된 경우
      Get.dialog(
        // 다이어로그 띄우기
        CustomSmallDialog(
          '기능 사용을 원하실 경우\n설정>앱 관리자>매너게이머에서\n알림 권한을 허용해 주세요.',
          '닫기',
          '설정으로 이동',
          () => Get.back(),
          () {
            Get.back();
            // 앱 설정으로 이동,
            openAppSettings();
          },
          2,
          3,
        ),
      );
      return false;
    }
  }

  // 카메라 권한 요청
  // 프로필 설정 및 수정할 때
  Future<bool> requestCameraPermission() async {
    // 권한 요청
    PermissionStatus status = await Permission.camera.request();
    // 결과 확인
    if (status.isGranted) {
      // 승인된 경우
      return true;
    } else {
      // 거부된 경우
      Get.dialog(
        // 다이어로그 띄우기
        CustomSmallDialog(
          '기능 사용을 원하실 경우\n설정>앱 관리자>매너게이머에서\n카메라 권한을 허용해 주세요.',
          '닫기',
          '설정으로 이동',
          () => Get.back(),
          () {
            Get.back();
            // 앱 설정으로 이동,
            openAppSettings();
          },
          2,
          3,
        ),
      );
      return false;
    }
  }

  // 사진 저장소 권한 요청
  // 프로필 설정 및 수정할 때
  Future<bool> requestStoragePermission() async {
    // 권한 요청
    PermissionStatus status = await Permission.storage.request();
    // 결과 확인
    if (status.isGranted) {
      // 승인된 경우
      print('승인');
      return true;
    } else {
      // 거절된 경우
      Get.dialog(
        // 다이어로그 띄우기
        CustomSmallDialog(
          '기능 사용을 원하실 경우\n설정>앱 관리자>매너게이머에서\n사진 접근을 허용해 주세요.',
          '닫기',
          '설정으로 이동',
          () => Get.back(),
          () {
            Get.back();
            // 앱 설정으로 이동,
            openAppSettings();
          },
          2,
          3,
        ),
      );
      return false;
    }
  }
}
