import 'package:gamegoapp/utilites/index/index.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final AppointmentController _controller = Get.find<AppointmentController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String uid = Get.arguments['uid'];
  final String postId = Get.arguments['postId'];
  final String postTitle = Get.arguments['postTitle'];
  // 캘린더 날짜 텍스트 크기
  final double _dateFontsize = 21;

  // 캘린더에서 선택한 약속날짜 년,월,일만(시, 분 X) 담는 변수
  // 캘린더 클릭 시 파란색 원으로 강조표시
  DateTime _date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  // 약속시간의 시, 분(년, 월, 일)을 담는 변수
  DateTime _time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaceData.screenPadding,
          vertical: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '날짜',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppSpaceData.heightSmall),
            TableCalendar(
              // 요일 표시 여부
              daysOfWeekVisible: false,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                // 선택된 날짜의 상태를 갱신합니다.
                setState(() {
                  this._date = selectedDay;
                  this._date = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                return isSameDay(_date, day);
              },

              locale: 'ko_KR',
              // 처음날짜
              firstDay: DateTime.now(),
              // 달력의 마지막 날짜
              lastDay: DateTime.utc(3000, 12, 31),
              // 선택 된 날짜
              focusedDay: _date,
              calendarStyle: CalendarStyle(
                // 마커 여러개이면 셀 영역을 벗어날지 여부
                canMarkersOverflow: false,
                // 자동정렬 여부
                markersAutoAligned: true,
                // 토,일 텍스트 스타일
                weekendTextStyle: TextStyle(
                  fontSize: _dateFontsize,
                  color: appBlackColor,
                ),
                // 다른 달의 날짜 텍스트 스타일
                outsideTextStyle: TextStyle(
                  fontSize: _dateFontsize,
                  color: Colors.grey[300],
                ),
                // 해당 달의 지난 날짜 텍스트 스타일
                disabledTextStyle: TextStyle(
                  fontSize: _dateFontsize,
                  color: Colors.grey[300],
                ),
                defaultTextStyle: TextStyle(
                  fontSize: _dateFontsize,
                  color: appBlackColor,
                ), // 기본 날짜 텍스트
                isTodayHighlighted: false,
                // 선택한 날짜 박스 스타일
                selectedDecoration: BoxDecoration(
                  color: appPrimaryColor,
                  shape: BoxShape.circle,
                ),
                // 선택한 날짜의 텍스트 스타일
                selectedTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appWhiteColor,
                ),
                // 테이블 패딩
                tablePadding: EdgeInsets.zero,
              ),
              headerStyle: HeaderStyle(
                // 헤더에 이상한 박스표시 표시 여부s
                formatButtonVisible: false,
                // 연.월.일 텍스트 스타일
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.25,
                  height: 1.sp,
                ),
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
            SizedBox(height: AppSpaceData.heightLarge),
            Row(
              children: [
                Text(
                  '시간',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 3.sp),
            // 시간 설정 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Jiffy(_time).format('a hh시 mm분'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  width: 20.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp)),
                          backgroundColor: appWhiteColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                              AppSpaceData.screenPadding,
                            ),
                            child: TimePickerSpinner(
                              time: _time,
                              alignment: Alignment.center,
                              is24HourMode: false,
                              normalTextStyle: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                                color: Colors.grey[300],
                              ),
                              highlightedTextStyle:
                                  Theme.of(context).textTheme.headlineSmall,
                              spacing: 30.sp,
                              itemHeight: 40.sp,
                              isForce2Digits: true,
                              minutesInterval: 5,
                              onTimeChange: (time) {
                                setState(() {
                                  _time = time;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '설정',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // 완료버튼
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(
          AppSpaceData.screenPadding,
        ),
        child: CustomFullFilledTextButton(
          '완료',
          () async {
            // <String>약속날짜와 시간
            String _dateTime = Jiffy(_date).format('yyyy-MM-dd') +
                ' ' +
                Jiffy(_time).format('HH:mm');
            // <DateTime> 약속날짜와 시간
            DateTime dateTime = DateTime.parse(_dateTime);
            // <Timestamp> 약속날짜와 시간
            Timestamp _timeStamp = Timestamp.fromDate(dateTime);
            final String _formatedTimeStamp =
                Jiffy(_timeStamp.toDate()).format('MM월 dd일 · a hh시 MM분');
            // 약속에 대한 메시지 인스턴스
            final MessageModel _messageModel = MessageModel(
              idFrom: _auth.currentUser!.uid,
              idTo: uid,
              // content: '$_formatedTimeStamp에\n약속을 설정했어요. 약속은 꼭 지켜주세요 !',
              content: '약속 설정 알림\n$_formatedTimeStamp',
              type: 'appoint',
              isDeleted: false,
              timestamp: Timestamp.now(),
            );

            final AppointmentModel _appointment = AppointmentModel(
              // 약속설정 유저의 uid
              idFrom: _auth.currentUser!.uid,
              // 약속설정을 당하는(?) 유저의 uid
              idTo: uid,
              timestamp: _timeStamp,
              createdAt: Timestamp.now(),
            );

            final NotificationModel _ntfModel = NotificationModel(
              idTo: uid,
              idFrom: _auth.currentUser!.uid,
              content: '',
              postId: postId,
              chatRoomId: chatRoomId,
              postTitle: postTitle,
              userName: _auth.currentUser!.displayName!,
              type: 'appoint',
              createdAt: Timestamp.now(),
            );
            Get.dialog(CustomBigDialog(
              '약속 설정',
              '${Jiffy(_timeStamp.toDate()).format('MM월 dd일 · a hh시 mm분')}',
              '취소',
              '완료',
              () => Get.back(),
              () async {
                // 약속설정
                await _controller.setAppointment(
                  chatRoomId,
                  _appointment,
                  _messageModel,
                  uid,
                  _ntfModel,
                );
                // 채팅페이지 설정한 약속시간이 업데이트 되기 위해서 호출
                await _controller.getAppointment(chatRoomId);
                Get.back();
                Get.back();
              },
              1,
              1,
            ));
          },
          appPrimaryColor,
        ),
      ),
    );
  }
}
