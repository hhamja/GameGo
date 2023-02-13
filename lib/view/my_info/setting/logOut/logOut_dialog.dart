import 'package:mannergamer/utilites/index/index.dart';

class LogOutDialog extends StatelessWidget {
  LogOutDialog({Key? key}) : super(key: key);

  final UserController _user = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return CustomSmallDialog(
      '정말 로그아웃 하시겠나요?',
      '취소',
      '확인',
      () => Get.back(),
      () async {
        await _user.signOut();
      },
    );
  }
}
