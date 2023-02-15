import 'package:mannergamer/utilites/index/index.dart';

class AppRoutes {
  AppRoutes._(); // 객체 인스턴스화 방지

  static final routes = [
    // MyApp
    GetPage(
      name: Paths.MyApp,
      page: () => MyApp(),
    ),

    // UserProfile
    GetPage(
      name: Paths.UserProfile,
      page: () => UserProfilePage(),
    ),

    // CHAT
    GetPage(
      name: Paths.ChatList,
      page: () => ChatListPage(),
    ),
    GetPage(
      name: Paths.Chatscreen,
      page: () => ChatScreenPage(),
    ),
    GetPage(
      name: Paths.NoUserChatScreen,
      page: () => NoUserChatScreenPage(),
    ),

    GetPage(
      name: Paths.Notification,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: Paths.AddPostDropDownBT,
      page: () => AddPostDropDownButton(),
    ),
    GetPage(
      name: Paths.AddPost,
      page: () => AddPostPage(),
    ),
    GetPage(
      name: Paths.HomePostList,
      page: () => HomePostList(),
    ),
    GetPage(
      name: Paths.Postdetail,
      page: () => PostDetailPage(),
    ),
    GetPage(
      name: Paths.DeleteDialog,
      page: () => DeleteDialog(),
    ),
    GetPage(
      name: Paths.EditPostDropDownButton,
      page: () => EditPostDropDownButton(),
    ),
    GetPage(
      name: Paths.EditPost,
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
      name: Paths.ReportDialog,
      page: () => ReportDialog(),
    ),
    GetPage(
      name: Paths.Report,
      page: () => ReportListPage(),
    ),
    GetPage(
      name: Paths.Home,
      page: () => Homepage(),
    ),

    // LOGIN

    GetPage(
      name: Paths.Main,
      page: () => MainLogoPage(),
    ),
    GetPage(
      name: Paths.UserName,
      page: () => CreateProfilePage(),
    ),
    GetPage(
      name: Paths.PhoneAuth,
      page: () => PhoneAuthPage(),
      binding: PhoneAuthBinding(),
    ),

    // MyInfoPage
    GetPage(
      name: Paths.My,
      page: () => MyInfoPage(),
    ),
    GetPage(
      name: Paths.FAQ,
      page: () => FAQPage(),
    ),
    GetPage(
      name: Paths.Feedback,
      page: () => FeedbackPage(),
    ),
    GetPage(
      name: Paths.AppNoticeList,
      page: () => AppNoticeListPage(),
    ),
    GetPage(
      name: Paths.NoticeDetail,
      page: () => NoticeDetailPage(),
    ),
    GetPage(
      name: Paths.ReceivedMannerEvaluation,
      page: () => ReceivedMannerEvaluationPage(),
    ),
    GetPage(
      name: Paths.MyPostList,
      page: () => MyPostListPage(),
    ),
    GetPage(
      name: Paths.ViewReceivedReviews,
      page: () => ViewReceivedReviews(),
    ),
    GetPage(
      name: Paths.ViewSentReviews,
      page: () => ViewSentReviews(),
    ),
    GetPage(
      name: Paths.ProfileEdit,
      page: () => EditMyProfilePage(),
    ),
    GetPage(
      name: Paths.Favorite,
      page: () => MyFavoriteList(),
    ),

    // SETTING
    GetPage(
      name: Paths.Setting,
      page: () => SettingPage(),
    ),
    GetPage(
      name: Paths.SignOut,
      page: () => SignOutPage(),
      binding: SignOutBinding(),
    ),
    GetPage(
      name: Paths.LogOutDialog,
      page: () => LogOutDialog(),
    ),
    GetPage(
      name: Paths.Account,
      page: () => AccountManagementPage(),
    ),
    GetPage(
      name: Paths.BlockUser,
      page: () => BlockUserManagement(),
    ),
    GetPage(
      name: Paths.FavoriteUser,
      page: () => FavoriteUserManagementPage(),
    ),
    GetPage(
      name: Paths.UnexposeUser,
      page: () => UnexposeUserManagementPage(),
    ),
    GetPage(
      name: Paths.EmailEnroll,
      page: () => EmailEnrollPage(),
    ),
    GetPage(
      name: Paths.EditPhone,
      page: () => PhoneNumberEditPage(),
    ),
    GetPage(
      name: Paths.SelfAuthentication,
      page: () => SelfAuthenticationPage(),
    ),

    // SPLASH
    GetPage(
      name: Paths.Splash,
      page: () => SplashPage(),
    ),
  ];
}
