import 'package:mannergamer/utilites/index/index.dart';

class InitialScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialScreenCntroller());
  }
}

class SignOutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class HomeDropDownBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageDropDownBTController());
  }
}

class CreatePostDropDownBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostDropDownBTController());
  }
}

class AddPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostDropDownBTController());
    Get.put(PostController());
  }
}

class HomePostListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}

class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}

class DeleteDialogBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}

class EditDropDownBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditDropDownController());
  }
}

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditDropDownController());
    Get.put(PostController());
  }
}

/* 이메일 회원가입 */
class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

/* 이메일 로그인 */
class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class PhoneAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
