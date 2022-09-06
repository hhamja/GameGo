import 'package:mannergamer/utilites/index.dart';

class LeaveAppPage extends StatefulWidget {
  const LeaveAppPage({Key? key}) : super(key: key);

  @override
  State<LeaveAppPage> createState() => _LeaveAppPageState();
}

class _LeaveAppPageState extends State<LeaveAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('탈퇴하기'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${userNameID}님, 안녕하세요!'),
            Text('매너게이머와 이별하려고 하시나요?  너무 아쉬워요...'),
            Text('${userNameID}님이 탈퇴하려는 이유가 궁금해요.'),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                iconSize: 30,
                buttonPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                ),
                buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                dropdownWidth: 230,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemHeight: 50,
                buttonElevation: 0,
                buttonHeight: 50,
                hint: Text('선택해주세요.'),
                items: leaveAppValue
                    .map(
                      (item) => DropdownMenuItem(
                        onTap: () {}, //여기에 각 항목별로 해당하는 문구를 배정시킨 if함수 넣자.
                        value: item,
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(height: 1.2),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedLeaveReason,
                dropdownOverButton: true,
                onChanged: (value) {
                  setState(() {
                    selectedLeaveReason = value as String;
                  });
                },
              ),
            ),
            showLeaveReasonSolution(),
          ],
        ),
      ),
    );
  }
}
