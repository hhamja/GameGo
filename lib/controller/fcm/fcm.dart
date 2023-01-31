import 'package:mannergamer/firebase_options.dart';
import 'package:mannergamer/utilites/index/index.dart';

class FCMController extends GetxController {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
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
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
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
      var data = _message.data as Map;
      print('타입이란? ${data['type']}');

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

    // 종료 상태에서 앱을 열게한 메시지를 가져오기
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // 종료 상태에서 알림 클릭시 동작
    if (initialMessage != null) _handleMessage(initialMessage);
    // 백그라운드 상태에서 푸시 알림 클릭하는 경우
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // 백그라운드에서 알림 클릭 시 액션
  void _handleMessage(RemoteMessage message) {
    final type = message.data['type'];
    print(message.data);
    print(message.data['postId']);
    print(message.data['chatRoomId']);
    print(message.data['uid']);
    print(message.data['userName']);
    print(message.data['profileUrl']);
    print(type);

    // 알림메시지 타입 확인
    if (type == 'message') {
      Get.toNamed(
        // 채팅 페이지로 이동하면서 데이터 아규먼트로 전달
        '/chatscreen',
        arguments: {
          // 게시글 정보를 불러오기 위한 post id
          'postId': message.data['postId'],
          // 채팅 메시지를 불러오기 위한 채팅 id
          'chatRoomId': message.data['chatRoomId'],
          // 채팅 상대정보를 보여주기 위한 uid, 닉네임, 매너나이, 프로필url
          'uid': message.data['uid'],
          'userName': message.data['userName'],
          // 'mannerAge': message.data['mannerAge'],
          'profileUrl': message.data['profileUrl'],
        },
      );
    } else if (type == 'favorite') {
      // 관심 게시글 알림
      Get.to(
        // 세부 게시글 페이지로 이동
        () => PostDetailPage(),
        arguments: message.data,
      );
    } else if (type == 'appoint') {
      // 약속 설정 알림
      Get.toNamed('/chat', arguments: message.data);
    } else if (type == 'review') {
      // 게임 후기 알림
      Get.to(
        // 채팅페이지로 이동
        () => ChatScreenPage(),
        arguments: message.data,
      );
      // 채팅페이지로 이동
    } else {
      // type == 'notice'
      // 앱 이벤트 및 소식 알림
      Get.toNamed('/chatscreen', arguments: message.data);
      // Get.to(
      //   // 스플래쉬 페이지 이동하여 유저정보에 따라 페이지 이동하도록 하기
      //   () => main(),
      //   arguments: message.data,
      // );
    }
  }
}
