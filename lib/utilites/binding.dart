import 'package:mannergamer/utilites/index.dart';

class SignOutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
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

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
  }
}

class SmsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
  }
}
