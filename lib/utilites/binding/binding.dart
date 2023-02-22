import 'package:gamegoapp/utilites/index/index.dart';

class InitialScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialScreenCntroller());
  }
}

class MyAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FcmTokenController());
    Get.put(FCMController());
  }
}

class SignOutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}

class HomePostListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePostController());
  }
}

class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailPostController());
  }
}

class DeleteDialogBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DeletePostController());
  }
}

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditPostController());
  }
}

// 이메일 회원가입
class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}

// 이메일 로그인
class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}

class PhoneAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
