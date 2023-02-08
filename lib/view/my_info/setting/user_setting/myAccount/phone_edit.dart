import 'package:mannergamer/utilites/index/index.dart';

class PhoneNumberEditPage extends StatefulWidget {
  const PhoneNumberEditPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberEditPage> createState() => _PhoneNumberEditPagestate();
}

class _PhoneNumberEditPagestate extends State<PhoneNumberEditPage> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '### #### ####', filter: {"#": RegExp(r'[0-9]')});
  final TextEditingController _phoneNumberController = TextEditingController();
  void _clearTextField() {
    _phoneNumberController.clear();
    setState(() {});
  }

  Color? get _bottomButtonColorChange {
    final text = _phoneNumberController.value.text;
    if (text.isPhoneNumber && text.length > 7) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '휴대폰 번호 변경',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('새로운 휴대폰 번호를 입력해주세요.'),
            SizedBox(height: 20),
            Text('현재 등록된 휴대폰 번호는 010-1234-8563'),
            SizedBox(height: 30),
            TextField(
              cursorColor: cursorColor,
              autofocus: true,
              showCursor: true,
              maxLines: 1,
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                hintText: '휴대폰 번호',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(gapPadding: 0),
                suffixIcon: _phoneNumberController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: _clearTextField,
                      ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                maskFormatter,
              ],
              onSubmitted: (_) {
                setState(() {
                  _phoneNumberController.clear();
                });
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            color: _bottomButtonColorChange,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('인증문자 받기', style: TextStyle(color: appWhiteColor)),
            ),
          ),
        ),
      ),
    );
  }
}
