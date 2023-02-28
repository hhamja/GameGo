import 'package:gamegoapp/firebase_options.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class FCMController extends GetxController {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // Local Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // 안드로이드 푸시 알림 채널
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // 이름
    description: 'This channel is used for important notifications.', // 설명
    playSound: true,
    showBadge: true,
    enableVibration: true,
    enableLights: true,

    // 중요도 max로 해야 포그라운드 상태에서 표시됨
    importance: Importance.max,
  );

  // 컨트롤러 시작 시
  // 토큰 받기, fcm 초기 함수 실행
  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  // FCM관련 초기 세팅
  // main에 바인딩하여 앱 시작 시 호출
  Future initialize() async {
    // Firebase 초기화해야 FirebaseMessaging 를 사용가능
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Android 에서 requestPermission()을 호출하지 않으면 수신되지 않는다.
    await _fcm.requestPermission(
      alert: true, // 유저의 디바이스에 알림을 보여줄 것이냐
      badge: true, // 읽지 않은 알림을 앱아이콘에 띄울 것이냐
      carPlay: true, // 기기가 CarPlay와 연결되어있을 때 알림을 띄울 것이냐
      criticalAlert: true,
      sound: true, // 알림이 보여질 때 소리를 낼 것이냐
      announcement: false, // 블루투스 스피커와 연동되어 있을 때, 알림을 읽어줄 수 있느냐
      provisional: false, // provisional 권한을 부여할 것이냐
    );

    // 로컬 노티 초기화
    // 초기화 전 메시지를 수신하게 되면 에러 발생하므로 초기화 부터 할 것
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
    );

    // FCM 포그라운드 수신
    // Notification Channel을 디바이스에 생성
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 포그라운드 메시지 스트림 수신
    FirebaseMessaging.onMessage.listen((RemoteMessage _message) {
      RemoteNotification? notification = _message.notification;
      AndroidNotification? android = _message.notification?.android;

      if (notification != null && android != null) {
        // 나에게 온 알림 메시지가 존재하는 경우
        //  flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
        // 포그라운드 알림 보여주기
        flutterLocalNotificationsPlugin.show(
          0, // id
          notification.title, // title
          notification.body, // body
          NotificationDetails(
            // 안드로이드 설정
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
              playSound: true,
            ),
          ),
        );
      }
    });

    // 백그라운드 상태에서 푸시 알림 클릭하는 경우
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    // 종료 상태에서 앱을 열게한 메시지를 가져오기
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // 종료 상태에서 알림 클릭시 동작
    if (initialMessage != null) _handleMessage(initialMessage);
  }

  // 백그라운드에서 알림 클릭 시 액션
  void _handleMessage(RemoteMessage message) {
    final type = message.data['type'];
    final screen = message.data['screen'];
    // 알림메시지 타입 확인
    if (type == 'message' || type == 'appoint' || type == 'review') {
      // 채팅메시지, 약속설정, 매너후기 알림
      NavigationService.navigateNamedTo(
        // 채팅 스크린 페이지로 이동
        screen,
        {
          'postId': message.data['postId'],
          'chatRoomId': message.data['chatRoomId'],
          'uid': message.data['uid'],
          'userName': message.data['userName'],
          'profileUrl': message.data['profileUrl'],
        },
      );
    } else if (type == 'favorite') {
      // 관심게시글 알림인 경우
      NavigationService.navigateNamedTo(
        // 세부 게시글 페이지로 이동
        screen,
        {
          'postId': message.data['postId'],
        },
      );
    } else {
      // type == 'notice'
      // 앱 이벤트 및 소식 알림
      // 페이지 이동 지정안하면 홈페이지 이동함
      debugPrint('앱 이벤트 및 소식 알림');
    }
  }
}
