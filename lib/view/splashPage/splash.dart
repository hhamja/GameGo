import 'package:gamego/utilites/index/index.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initial 컨트롤러 바인딩 -> 1.5초뒤 유저정보에 따라 페이지 이동
    return WillPopScope(
      // 해당 위젯은 취소키 방지 역할
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: appWhiteColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(35.sp),
                  child: Image.asset(
                    'assets/main_logo.png',
                    color: appPrimaryColor,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
                SizedBox(
                  height: 10.84.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
