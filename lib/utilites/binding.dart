import 'package:mannergamer/utilites/index.dart';

class HomePostListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}

class CreatePageDropButtonBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostDropDownBTController());
  }
}

class EditPageDropButtonBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditDropDownController());
  }
}

class HomePageDropButtonBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageDropDownBTController());
  }
}

class InitialScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialScreenCntroller());
  }
}

class UserAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
  }
}
