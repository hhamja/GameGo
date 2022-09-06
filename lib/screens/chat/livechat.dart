import 'package:mannergamer/utilites/index.dart';

class UserChatDetail extends StatelessWidget {
  UserChatDetail({Key? key}) : super(key: key);
  final Duration duration = new Duration();
  final Duration position = new Duration();
  final bool isPlaying = false;
  final bool isLoading = false;
  final bool isPause = false;

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('(상대유저이름)'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.more_vert), //아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BubbleNormal(
                text: 'bubble normal with tail',
                isSender: false,
                color: Color(0xFF1B97F3),
                tail: true,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              BubbleNormal(
                text: 'bubble normal with tail',
                isSender: true,
                color: Color(0xFFE8E8EE),
                tail: true,
                sent: true,
              ),
              DateChip(
                date: new DateTime(now.year, now.month, now.day - 2),
              ),
              BubbleNormal(
                text: 'bubble normal without tail',
                isSender: false,
                color: Color(0xFF1B97F3),
                tail: false,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              BubbleNormal(
                text: 'bubble normal without tail',
                color: Color(0xFFE8E8EE),
                tail: false,
                sent: true,
                seen: true,
                delivered: true,
              ),
              BubbleSpecialOne(
                text: 'bubble special one with tail',
                isSender: false,
                color: Color(0xFF1B97F3),
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              DateChip(
                date: new DateTime(now.year, now.month, now.day - 1),
              ),
              BubbleSpecialOne(
                text: 'bubble special one with tail',
                color: Color(0xFFE8E8EE),
                seen: true,
              ),
              BubbleSpecialOne(
                text: 'bubble special one without tail',
                isSender: false,
                tail: false,
                color: Color(0xFF1B97F3),
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              BubbleSpecialOne(
                text: 'bubble special one without tail',
                tail: false,
                color: Color(0xFFE8E8EE),
                sent: true,
              ),
              BubbleSpecialTwo(
                text: 'bubble special tow with tail',
                isSender: false,
                color: Color(0xFF1B97F3),
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              DateChip(
                date: now,
              ),
              BubbleSpecialTwo(
                text: 'bubble special tow with tail',
                isSender: true,
                color: Color(0xFFE8E8EE),
                sent: true,
              ),
              BubbleSpecialTwo(
                text: 'bubble special tow without tail',
                isSender: false,
                tail: false,
                color: Color(0xFF1B97F3),
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              BubbleSpecialTwo(
                text: 'bubble special tow without tail',
                tail: false,
                color: Color(0xFFE8E8EE),
                delivered: true,
              ),
              BubbleSpecialThree(
                text: 'bubble special three without tail',
                color: Color(0xFF1B97F3),
                tail: false,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
              BubbleSpecialThree(
                text: 'bubble special three with tail',
                color: Color(0xFF1B97F3),
                tail: true,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
              BubbleSpecialThree(
                text: "bubble special three without tail",
                color: Color(0xFFE8E8EE),
                tail: false,
                isSender: false,
              ),
              BubbleSpecialThree(
                text: "bubble special three with tail",
                color: Color(0xFFE8E8EE),
                tail: true,
                isSender: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
