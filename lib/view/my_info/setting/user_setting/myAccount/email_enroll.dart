import 'package:mannergamer/utilites/index/index.dart';

class EmailEnrollPage extends StatefulWidget {
  const EmailEnrollPage({Key? key}) : super(key: key);

  @override
  State<EmailEnrollPage> createState() => _EmailEnrollPageState();
}

class _EmailEnrollPageState extends State<EmailEnrollPage> {
  final TextEditingController _emailController = TextEditingController();
  void _clearTextField() {
    _emailController.clear();
    setState(() {});
  }

  Color? get _bottomButtonColorChange {
    final text = _emailController.value.text;
    if (text.isEmail) {
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
          '이메일 등록',
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
            Text('안전한 계정관리를 위해 이메일을 등록해주세요!'),
            SizedBox(height: 20),
            TextField(
              cursorColor: cursorColor,
              autofocus: true,
              showCursor: true,
              maxLines: 1,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                hintText: '이메일 주소',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                suffixIcon: _emailController.text.isEmpty
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
                FilteringTextInputFormatter.allow(RegExp(r'[a-z|A-Z|0-9|@,.]'))
              ],
              onSubmitted: (_) {
                setState(() {
                  _emailController.clear();
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
              child: Text('인증메일 받기', style: TextStyle(color: appWhiteColor)),
            ),
          ),
        ),
      ),
    );
  }
}
