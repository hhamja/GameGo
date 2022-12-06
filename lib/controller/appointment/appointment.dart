import 'package:mannergamer/utilites/index/index.dart';

class AppointmentController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');

  /* 약속 날짜 담는  Rx String 변수 */
  RxString appointmentDate = ''.obs;
  /* 반응 타임스템프 변수 */
  var x = Timestamp.now().obs;
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

/* 약속시간 받기 */
  Future getAppointment(chatRoomId) async {
    return await _chatDB
        .doc(chatRoomId)
        .collection('appointment')
        .doc('appointmentDate')
        .get()
        .then(
      (value) {
        var doc = value.data() as Map;
        var data = doc['timestamp'];
        final String _appointmentdate =
            Jiffy(data.toDate()).format('MM/dd a hh:mm');
        appointmentDate.value = _appointmentdate;
      },
    );
  }
}
