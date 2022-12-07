import 'package:mannergamer/utilites/index/index.dart';

class AppointmentController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');

  /* 약속 날짜 담는  Rx String 변수 */
  RxString appointmentDate = ''.obs;
  /* DateTime 변수 */
  var toDatetime = DateTime.now().obs;
  /* 약속설정이 되어있는지를 나타내는 bool변수 */
  RxBool isSetAppointment = false.obs;

  /* 약속설정하기 
  * 문서하나만 만들어서 약속 설정 시 계속 업데이트할 것 */
  Future setAppointment(chatRoomId, AppointmentModel appointmentModel) async {
    await _chatDB
        .doc(chatRoomId)
        .collection('appointment')
        .doc('appointmentDate')
        .set({
      'timestamp': appointmentModel.timestamp,
      'createdAt': appointmentModel.createdAt,
    });
  }

  /* 약속시간 받기 + 약속설정 여부 bool변수에 담기 */
  Future getAppointment(chatRoomId) async {
    final ref = await _chatDB
        .doc(chatRoomId)
        .collection('appointment')
        .doc('appointmentDate')
        .get();
    //약속설정 O ?
    if (ref.exists) {
      //약속설정한 날짜 데이터로 받기
      _chatDB
          .doc(chatRoomId)
          .collection('appointment')
          .doc('appointmentDate')
          .get()
          .then(
        (value) {
          var doc = value.data() as Map;
          var _timestamp = doc['timestamp']; //받은 시간이 이미 지났는지에 대한 if문을 view에서 수행
          toDatetime.value = _timestamp.toDate();
          final String _appointmentdate =
              Jiffy(_timestamp.toDate()).format('MM/dd a hh:mm');
          appointmentDate.value = _appointmentdate;
        },
      );
      //약속설정 했다는 것을 true로 반환
      isSetAppointment.value = true;
    }
    //약속설정 X ? 약속설정한 날짜 데이터로 받기
    else {
      //약속설정 안했다는 것을 false로 반환
      isSetAppointment.value = false;
    }
  }
}
