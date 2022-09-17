//바인딩을 쓰는게 좋을지 고민해 보자.
// 이유 : 뒤로가기 할 때 컨트롤러를 끈다고 하니.... 음... 그리고 오히려 바인딩 하는게 코디가 그리 이쁘게 나오진 않을거 같기도하다.

import 'package:mannergamer/utilites/index.dart';

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

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}

class UserAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
  }
}
