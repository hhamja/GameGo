import 'package:mannergamer/utilites/index/index.dart';

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  /* 알림 on/off 바텀시트 클릭에 대한 bool값 */
  //처음 값은 true (나중에 아마 컨트롤러로 따로 빼야할듯? 상태값 저장해야함)
  bool _isAlramOnOff = true;
  /* 차단 바텀시트 클릭에 대한 bool값 */
  bool _isBlockOnOff = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 180, //개당 60
      child: Column(
        //알림끄기, 차단, 신고, 나가기(red), 취소
        children: [
          CustomButtomSheet(_isAlramOnOff ? '알림끄기' : '알림켜기', Colors.blue, () {
            setState(() => _isAlramOnOff = !_isAlramOnOff); //토글버튼
            Get.back();
          }),
          // CustomButtomSheet(!_isBlockOnOff ? '차단하기' : '차단 해제하기', Colors.blue,
          //     () {
          //   setState(() => _isBlockOnOff = !_isBlockOnOff); //토글버튼
          //   Get.back();
          // }),
          CustomButtomSheet('신고하기', Colors.blue, () {
            Get.back();
            Get.toNamed('/report'); //신고목록 페이지로 이동
          }),
          // CustomButtomSheet('채팅방 나가기', Colors.redAccent, () {}),
          CustomButtomSheet('취소', Colors.blue, () => Get.back()),
        ],
      ),
    );
  }
}
