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
    // 게시글 추가하는 +버튼
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appPrimaryColor,
    ),
    // 앱바
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appBackgroudColor,
      iconTheme: IconThemeData(
        color: appBlackColor,
        size: 20.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: appBlackColor,
        size: 20.sp,
      ),
    ),
    // 바텀시트
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appBackgroudColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appBackgroudColor,
      elevation: 0,
    ),
    textTheme: AppTextStyle.textTheme,
    // 앱 기본 폰트
    fontFamily: 'NotoSansCJKkr',
  );
}
