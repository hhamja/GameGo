import 'package:mannergamer/utilites/index/index.dart';

class FCMController extends GetxController {
  /* fcm 인스턴스 */
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  /* Local Notification */
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  /* 안드로이드 푸시 알림 채널 */
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // 이름
    description: 'This channel is used for important notifications.', // 설명
    importance: Importance.max, //중요도 max로 해야 포그라운드 상태에서 표시됨
  );

  /* Rx변수의 메시지 
  * 알림표시는 밑에 함수에서 하는 것이다.
  * 이 변수는 FCM에서 온 메시지를 담아서 알림목록에 표시하거나 받은 메시지를 DB에 넣거나 등등. 즉 state로서 관리하기 위함이다 */
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  /* 컨트롤러 시작 시
  * 토큰 받기, fcm 초기 함수 실행 */
  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  /* FCM관련 초기 세팅 
  * main에 바인딩하여 앱 시작 시 호출 */
  Future _initialize() async {
    // Firebase 초기화해야 FirebaseMessaging 를 사용가능
    await Firebase.initializeApp();
    // Android 에서 requestPermission()을 호출하지 않으면 수신되지 않는다.
    await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    /* FCM 포그라운드 수신 */

    // Notification Channel을 디바이스에 생성
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    //FlutterLocalNotificationsPlugin 초기화
    await flutterLocalNotificationsPlugin.initialize(InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));

    // 메시지를 스트림으로 받기
    FirebaseMessaging.onMessage.listen((RemoteMessage _message) {
      message.value = _message; //메시지 Rx 변수에 담기
      RemoteNotification? notification = _message.notification;
      AndroidNotification? android = _message.notification?.android;

      // 메시지가 존재한다면?
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          0, //id
          notification.title, //title
          notification.body, //body
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, //채널 id
              channel.name, //채널 이름
              channelDescription: channel.description, //채널 설명
              icon: '@mipmap/ic_launcher', //
            ), //안드로이드 설정
          ),
        );
      }
    });

    /* 백그라운드 클릭 액션
    * 백그라운드 수신은 기본적으로 FCM에서 되므로 따로 안해도 된다 */
    // 1. 앱 완전 종료상태에서 푸시 알림 클릭하는 경우
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _handleMessage(initialMessage);
    // 2. 백그라운드 상태에서 푸시 알림 클릭하는 경우
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /*  백그라운드에서 알림 클릭 시 액션 */
  void _handleMessage(RemoteMessage _message) {
    print('message = ${_message.notification!.title}');
    Get.dialog(AlertDialog(
      title: Text(_message.notification?.title ?? 'TITLE'),
      content: Text(_message.notification?.body ?? 'BODY'),
    ));
    // if (message.data['type'] == 'chat') {
    //   Get.toNamed('/chat', arguments: message.data); //채팅페이지로 이동
    // }
  }
}
