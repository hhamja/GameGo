import 'package:mannergamer/utilites/index/index.dart';

class MainLogoPage extends StatelessWidget {
  MainLogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //디바이스 전체 w
    print(MediaQuery.of(context).size.width);
    //디바이스 전체 h
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        color: appPrimaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(30.sp),
                child: Image.asset(
                  'assets/main_logo.png',
                  color: appWhiteColor,
                  width: 40.w,
                  height: 40.h,
                ),
              ),
              Container(
                width: 60.w,
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  border: Border.all(
                    color: appWhiteColor,
                    width: 0.3.w,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.sp),
                  ),
                ),
                child: TextButton(
                  child: Text(
                    '휴대폰으로 시작하기',
                    style: TextStyle(
                      fontSize: 12.sp,
                      letterSpacing: 0.25.sp,
                      color: appWhiteColor,
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => PhoneAuthPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
