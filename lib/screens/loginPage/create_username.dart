import 'package:mannergamer/utilites/index.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({Key? key}) : super(key: key);

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  //닉네임 입력에 대한 에러택스트 조건식
  Text? get _showErrorText {
    final text = _usernameController.value.text;
    if (text.isEmpty) {
      return Text(
        '닉네임을 입력해주세요!',
        style: TextStyle(color: Colors.red),
      );
    }
    if (text.length < 2) {
      return Text(
        '닉네임은 2자 이상 입력해주세요.',
        style: TextStyle(color: Colors.red),
      );
    }
    return Text('프로필 사진과 닉네임을 입력해주세요.');
  }

  Color? get _bottomButtonColorChange {
    final text = _usernameController.value.text;
    if (text.isEmpty || text.length < 2) {
      return Colors.grey;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('프로필 설정'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Get.offAll(Homepage()),
            child: Text(
              '완료',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            child: Icon(Icons.person_pin),
            radius: 80,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요.',
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                counterText: '',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              maxLines: 1,
              showCursor: true,
              controller: _usernameController,
              maxLength: 12,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'))
              ]),
          SizedBox(
            height: 10,
          ),
          Container(
            child: _showErrorText,
          )
        ],
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: _bottomButtonColorChange,
            child: TextButton(
              onPressed: () {
                Get.back();
                setState(() {});
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('완료', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
