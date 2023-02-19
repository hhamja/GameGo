import 'package:gamego/utilites/index/index.dart';

class AlarmBottomSheet extends StatelessWidget {
  const AlarmBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appWhiteColor,
      height: 420,
      child: Column(
        children: [
          CustomButtomSheet('없음', appBlackColor, () {}), //없음
          CustomButtomSheet('5분 전', appBlackColor, () {}), //5분 전
          CustomButtomSheet('10분 전', appBlackColor, () {}), //10분 전
          CustomButtomSheet('15분 전', appBlackColor, () {}), //15분 전
          CustomButtomSheet('30분 전', appBlackColor, () {}), //30분 전
          CustomButtomSheet('1시간 전', appBlackColor, () {}), //1시간 전
          CustomButtomSheet('2시간 전', appBlackColor, () {}), //2시간 전
        ],
      ),
    );
  }
}
