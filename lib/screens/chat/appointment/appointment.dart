import 'package:mannergamer/utilites/index/index.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  /* 캘린더에서 선택한 날짜, 파란색 원으로 강조표시 됨
  * 여기서 선택한 변수를 DB appointment에 저장 */
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime(2022, 11, 16);

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
              daysOfWeekVisible: false, //요일 표시 여부
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                // 선택된 날짜의 상태를 갱신합니다.
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                return isSameDay(selectedDay, day);
              },
              daysOfWeekHeight: 20, //월~금 글씨가 가려져서 높이주기
              locale: 'ko_KR', //한국어로 바꾸기
              firstDay: DateTime.now(), //처음날짜
              lastDay: DateTime.utc(3000, 12, 31), //달력의 마지막 날짜
              focusedDay: focusedDay, //선택 된 날짜
              calendarStyle: CalendarStyle(
                canMarkersOverflow: false, //마커 여러개이면 셀 영역을 벗어날지 여부
                markersAutoAligned: true, //자동정렬 여부
                weekendTextStyle:
                    TextStyle(fontSize: 15, color: Colors.black), //토,일 텍스트 스타일
                outsideTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[300],
                ), //다른 달의 날짜 텍스트 스타일
                disabledTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[300],
                ), //해당 달의 지난 날짜 텍스트 스타일
                defaultTextStyle: TextStyle(
                  fontSize: 15,
                ), //기본 날짜 텍스트
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ), //선택한 날짜 박스 스타일
                selectedTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), //선택한 날짜의 텍스트 스타일
                tablePadding: EdgeInsets.zero, //테이블 패딩
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false, //헤더에 이상한 박스표시 표시 여부
                titleTextStyle: TextStyle(
                  fontSize: 15,
                ), //연.월.일 텍스트 스타일
                titleCentered: true, //연.월.일 가운데 정렬 여부
                leftChevronPadding: EdgeInsets.zero,
                rightChevronPadding: EdgeInsets.zero,
                headerPadding: EdgeInsets.fromLTRB(0, 0, 0, 10), //헤더 박스 패딩
                leftChevronIcon: Icon(
                  Icons.arrow_left,
                ), //왼쪽 화살표 아이콘 버튼
                rightChevronIcon: Icon(
                  Icons.arrow_right,
                ), //오른쪽 화살표 아이콘 버튼
              ),
            ),

            /* 시간 지정 버튼 */
            SizedBox(
              width: double.infinity,
              // height: 35,
              child: TextButton(
                onPressed: () {
                  Get.dialog(
                    TimePickerDialog(
                      initialTime: TimeOfDay.now(),
                    ),
                  );
                },
                child: Text(
                  '오후 08:00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: Colors.grey[200],
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
            SizedBox(height: 20),
            /* 알림 설정 */
            Text(
              '알림',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '없음',
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {
                Get.bottomSheet(
                  AlarmBottomSheet(),
                );
              }, //알림 '~전' 시간선택하는 다이어로그 띄우기
              trailing: Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            /* 완료버튼 */
            SizedBox(
              height: 40,
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
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
