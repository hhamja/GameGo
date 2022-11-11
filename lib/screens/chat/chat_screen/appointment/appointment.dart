import 'package:mannergamer/utilites/index/index.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  Duration initialtimer = new Duration();
  var time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('약속 설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* 약속 날짜 정하기 */
            TableCalendar(
              locale: 'ko_KR',
              currentDay: DateTime.now(),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(3000, 12, 31),
              focusedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                markersAutoAligned: true,
                canMarkersOverflow: false,
                tablePadding: EdgeInsets.zero,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronMargin: EdgeInsets.zero,
                rightChevronMargin: EdgeInsets.zero,
                leftChevronPadding: EdgeInsets.zero,
                rightChevronPadding: EdgeInsets.zero,
                headerPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                leftChevronIcon: Icon(
                  Icons.arrow_left,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '시간',
                  style: TextStyle(
                    fontSize: 15,
                    //  fontWeight: FontWeight.w700,
                  ),
                ),
                /* 시간 지정 버튼 */
                TextButton(
                  onPressed: () {
                    Get.dialog(
                      TimePickerDialog(
                        initialTime: TimeOfDay.now(),
                      ),
                    );
                  },
                  child: Text(
                    '오후 08:00',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.black12,
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, height: 30),
            /* 알림 설정 */
            Text(
              '알림',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '30분 전',
              ),
              onTap: () {
                Get.bottomSheet(
                  AlarmBottomSheet(),
                );
              }, //알림 '~전' 시간선택하는 다이어로그 띄우기
              trailing: Icon(Icons.arrow_drop_down_sharp),
            ),
            Divider(thickness: 1, height: 30),
            /* 완료버튼 */
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.zero)),
            ),
          ],
        ),
      ),
    );
  }
}
