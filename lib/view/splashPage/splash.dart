import 'package:mannergamer/utilites/index/index.dart';

class SplashPage extends StatelessWidget {
  //initial 컨트롤러 바인딩 -> 1.5초뒤 유저정보에 따라 페이지 이동
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    var fullWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            //height : MediaQuery.of(context).size.height,
            //color: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: fullHeight * 0.384375),
                Container(
                  child: Text('매너게이머'),
                  width: fullWidth * 0.616666,
                  height: fullHeight * 0.0859375,
                ),
                Expanded(child: SizedBox()),
                Align(
                  child: Text(
                    "© Copyright 2022. mannergamer",
                    style: TextStyle(
                        fontSize: fullWidth * (14 / 360), color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0625,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
