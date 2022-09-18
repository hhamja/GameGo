import 'package:mannergamer/utilites/index.dart';

class AppRoutes {
  AppRoutes._(); // 객체 인스턴스화 방지

  static final routes = [
    /* CHAT */
    GetPage(
      name: Paths.Chat,
      page: () => ChatListPage(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => ChattingPage(),
    ),

    /* HOME */
    GetPage(
      name: Paths.AddPost,
      page: () => HomeDropDownButton(),
    ),
    GetPage(
      name: Paths.Notification,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => CreatePostDropDownButton(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => AddPostPage(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => HomePostList(),
    ),
    GetPage(
      name: Paths.Postdetail,
      page: () => PostDetailPage(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => DeleteDialog(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => EditPostDropDownButton(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => EditPostPage(),
    ),
    GetPage(
      name: Paths.Illegal,
      page: () => IllegallyPostedPage(),
    ),
    GetPage(
      name: Paths.OtherReason,
      page: () => OtherReasonsPage(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => ReportDialog(),
    ),
    GetPage(
      name: Paths.Report,
      page: () => ReportPostPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => Homepage(),
    ),

    /* LOGIN */
    GetPage(
      name: Paths.Signup,
      page: () => SignUPPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => FindAccountPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => MainPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => SMSPage(),
    ),

    /* MYPAGE */
    GetPage(
      name: Paths.Home,
      page: () => MyPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => FAQPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => FeedbackPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => AppNoticeListPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => NoticeDetailPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => MannerAgePage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => ReceivedReviewPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => ReceivedMannerEvaluationPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => MyPostListPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => ViewReceivedReviews(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => ViewSentReviews(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => ProfileEditPage(),
    ),

    /* SETTING */
    GetPage(
      name: Paths.Home,
      page: () => SettingPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => SettingAlram(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => DeleteUserPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => LogOutDialog(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => AccountManagementPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => BlockUserManagement(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => FavoriteUserManagementPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => UnexposeUserManagementPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => EmailEnrollPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => PhoneNumberEditPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => SelfAuthenticationPage(),
    ),

    /* SPLASH */
    GetPage(
      name: Paths.Splash,
      page: () => SplashPage(),
    ),
  ];
}
