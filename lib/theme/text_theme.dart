import 'package:mannergamer/utilites/index/index.dart';

class AppTextStyle {
  // 반응형 앱을 위해 폰트사이즈 sp로 설정
  static final TextTheme textTheme = TextTheme(
    // 헤드라인
    headlineLarge: TextStyle(
      // 32-40
      fontSize: 32.sp,
      color: appLightBlack,
    ),
    headlineMedium: TextStyle(
      // 28-36
      fontSize: 28.sp,
      color: appLightBlack,
    ),
    headlineSmall: TextStyle(
      // 24-32
      fontSize: 24.sp,
      color: appLightBlack,
    ),

    // 제목
    titleLarge: TextStyle(
      // 22-28
      fontSize: 22.sp,
      color: appLightBlack,
    ),
    titleMedium: TextStyle(
      // 16-24
      fontSize: 16.sp,
      letterSpacing: 0.15.sp,
      fontWeight: FontWeight.w500,
      color: appLightBlack,
    ),
    titleSmall: TextStyle(
      // 14-20
      fontSize: 14.sp,
      letterSpacing: 0.1.sp,
      fontWeight: FontWeight.w500,
      color: appLightBlack,
    ),

    // 본문
    bodyLarge: TextStyle(
      // 16-24
      fontSize: 16.sp,
      letterSpacing: 0.5.sp,
      color: appLightBlack,
    ),
    bodyMedium: TextStyle(
      // 14-20
      fontSize: 14.sp,
      letterSpacing: 0.25.sp,
      color: appLightBlack,
    ),
    bodySmall: TextStyle(
      // 12-16
      fontSize: 12.sp,
      letterSpacing: 0.4.sp,
      color: appLightBlack,
    ),

    // 본문보다 100 두꺼운 w500 라벨택스트
    labelLarge: TextStyle(
      // 14-20
      fontSize: 14.sp,
      letterSpacing: 0.1.sp,
      fontWeight: FontWeight.w500,
      color: appLightBlack,
    ),
    labelMedium: TextStyle(
      // 12-16
      fontSize: 12.sp,
      letterSpacing: 0.5.sp,
      fontWeight: FontWeight.w500,
      color: appLightBlack,
    ),
    labelSmall: TextStyle(
      // 11-16
      fontSize: 11.sp,
      letterSpacing: 0.5.sp,
      fontWeight: FontWeight.w500,
      color: appLightBlack,
    ),
  );

  // 버튼 텍스트 스타일 지정
  static final fullButtonTextStyle = TextStyle(
    // 14-20
    fontSize: 14.sp,
    letterSpacing: 0.1.sp,
    fontWeight: FontWeight.w500,
    color: appLightWhite,
  );
}
