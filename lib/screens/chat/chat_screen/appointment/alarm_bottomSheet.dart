import 'package:mannergamer/utilites/index/index.dart';

class AlarmBottomSheet extends StatelessWidget {
  const AlarmBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 420,
      child: Column(
        children: [
          CustomButtomSheet('없음', Colors.black, () {}), //없음
          CustomButtomSheet('5분 전', Colors.black, () {}), //5분 전
          CustomButtomSheet('10분 전', Colors.black, () {}), //10분 전
          CustomButtomSheet('15분 전', Colors.black, () {}), //15분 전
          CustomButtomSheet('30분 전', Colors.black, () {}), //30분 전
          CustomButtomSheet('1시간 전', Colors.black, () {}), //1시간 전
          CustomButtomSheet('2시간 전', Colors.black, () {}), //2시간 전
        ],
      ),
    );
  }
}
