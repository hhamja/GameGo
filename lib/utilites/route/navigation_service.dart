import 'package:mannergamer/utilites/index/index.dart';

class NavigationService {
  // 네비게이션 글로벌 키
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  // 네임드 페이지 이동
  static Future<dynamic> navigateNamedTo(String routeName, argument) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }
}
