import 'package:mannergamer/utilites/index.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashPage()),
    GetPage(name: '/login', page: () => LogInPage()),
    GetPage(name: '/home', page: () => Homepage()),
    GetPage(
      name: '/signUP',
      page: () => CreateUsername(),
      binding: UserAuthBinding(),
    ),
    GetPage(name: '/chat', page: () => ChatListPage()),
    GetPage(name: '/ntf', page: () => NotificationPage()),
    GetPage(name: '/postDetail', page: () => UserPostDetailPage()),
    GetPage(name: '/reportList', page: () => ReportPostPage()),
    GetPage(name: '/illegal', page: () => IllegallyPostedPage()),
    GetPage(name: '/otherReason', page: () => OtherReasonsPage()),
    GetPage(
      name: '/addPost',
      page: () => HomeAddPost(),
      binding: CreatePageDropButtonBinding(),
    ),
  ];
}
