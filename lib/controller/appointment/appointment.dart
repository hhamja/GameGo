import 'package:mannergamer/utilites/index/index.dart';

class AppointmentController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  final NtfController _ntf = Get.put(NtfController());

  // 약속 날짜 담는  Rx String 변수
  RxString appointmentDate = ''.obs;
  // DateTime 변수
  var toDatetime = DateTime.now().obs;
  // 약속설정이 되어있는지를 나타내는 bool변수
  RxBool isSetAppointment = false.obs;
  // 약속설정했다는 메시지를 채팅 페이지 보여주기 위한 bool변수
  RxBool isShowMessage = false.obs;

  // 약속설정하기
  // 문서하나만 만들어서 약속 설정 시 계속 업데이트할 것
  Future setAppointment(chatRoomId, AppointmentModel appointmentModel,
      MessageModel messageModel, uid, NotificationModel ntfModel) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    // 해당 채팅의 약속 하위 컬렉션에 데이터 추가
    _batch.set(
      _chatDB.doc(chatRoomId).collection('appointment').doc('appointmentDate'),
      {
        'idFrom': appointmentModel.idFrom,
        'idTo': appointmentModel.idTo,
        'timestamp': appointmentModel.timestamp,
        'createdAt': appointmentModel.createdAt,
      },
    );
    // 메시지로 표시하기 메시지 하위 컬렉션에 메시지 추가
    _batch.set(
      _chatDB.doc(chatRoomId).collection('message').doc(),
      // doc()에 아무값도 지정하지 않으면 임의의 랜덤 id값을 넣음
      {
        'content': messageModel.content,
        'idFrom': messageModel.idFrom,
        'idTo': messageModel.idTo,
        'type': messageModel.type,
        'timestamp': messageModel.timestamp,
      },
    );
    // 상대 uid의 unReadCount +1
    _batch.update(
      _chatDB.doc(chatRoomId),
      {
        'unReadCount.${uid}': FieldValue.increment(1),
      },
    );
    // 약속설정 notification에 추가
    _ntf.addNotification(ntfModel, _batch);
    _batch.commit();
  }

  // 약속시간 받기 + 약속설정 여부 bool변수에 담기
  Future getAppointment(chatRoomId) async {
    final ref = await _chatDB
        .doc(chatRoomId)
        .collection('appointment')
        .doc('appointmentDate')
        .get();
    if (ref.exists) {
      // 약속설정 O ?
      // 약속설정한 날짜 데이터로 받기
      _chatDB
          .doc(chatRoomId)
          .collection('appointment')
          .doc('appointmentDate')
          .get()
          .then(
        (value) {
          var doc = value.data() as Map;
          // 받은 시간이 이미 지났는지에 대한 if문을 view에서 수행
          var _timestamp = doc['timestamp'];
          toDatetime.value = _timestamp.toDate();
          final String _appointmentdate =
              Jiffy(_timestamp.toDate()).format('MM/dd a hh:mm');
          appointmentDate.value = _appointmentdate;
        },
      );

      isSetAppointment.value = true;
    } else {
      // 약속설정 X
      isSetAppointment.value = false;
    }
  }
}
