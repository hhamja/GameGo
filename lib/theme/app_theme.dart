import 'package:mannergamer/utilites/index/index.dart';

class AppThemeData {
  static final ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light().copyWith(
      primary: appPrimaryColor,
      onPrimary: null,
    ),
    primaryColor: appPrimaryColor,
    scaffoldBackgroundColor: appBackgroudColor,
    // 홈페이지 + 버튼
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // backgroundColor: Colors.blue,
        ),
    // 앱바
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appBackgroudColor,
      iconTheme: IconThemeData(
        color: appBlackColor,
        size: 25.sp,
      ),
    ),
    // 하단 탭바
    tabBarTheme: TabBarTheme(),
    textTheme: AppTextStyle.textTheme,
    // 앱 전체적으로 기본폰트를 에스코어 드림
    fontFamily: 'NotoSansCJKkr',
  );
}
