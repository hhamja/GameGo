import 'package:mannergamer/utilites/index.dart';

class AppRoutes {
  AppRoutes._(); // 객체 인스턴스화 방지

  static final routes = [
    /* CHAT */
    GetPage(
      name: Paths.ChatList,
      page: () => ChatListPage(),
    ),
    GetPage(
      name: Paths.Chatting,
      page: () => ChattingPage(),
    ),

    /* HOME */
    GetPage(
      name: Paths.HomeDropDownBT,
      page: () => HomeDropDownButton(),
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
      name: Paths.FindAccount,
      page: () => FindAccountPage(),
    ),
    GetPage(
      name: Paths.Main,
      page: () => MainPage(),
    ),
    GetPage(
      name: Paths.SMS,
      page: () => SMSPage(),
    ),

    /* MYPAGE */
    GetPage(
      name: Paths.My,
      page: () => MyPage(),
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
      name: Paths.MannerAge,
      page: () => MannerAgePage(),
    ),
    GetPage(
      name: Paths.ReceivedReview,
      page: () => ReceivedReviewPage(),
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
      page: () => ProfileEditPage(),
    ),

    /* SETTING */
    GetPage(
      name: Paths.Setting,
      page: () => SettingPage(),
    ),
    GetPage(
      name: Paths.Alram,
      page: () => SettingAlram(),
    ),
    GetPage(
      name: Paths.SignOut,
      page: () => SignOutPage(),
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

    /* SPLASH */
    GetPage(
      name: Paths.Splash,
      page: () => SplashPage(),
    ),
  ];
}
