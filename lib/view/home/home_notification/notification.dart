import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/utilites/index/index.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> entryText = <String>[
    '1번 글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글',
    '2번 글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글',
    '3번 글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글',
    '4번 글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글',
    '5번 글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글글',
  ];

  final List<CustomCircleFilledIcon> entryIcons = <CustomCircleFilledIcon>[
    CustomCircleFilledIcon(Colors.red, CupertinoIcons.heart), //관심 게시글
    CustomCircleFilledIcon(Colors.yellow, CupertinoIcons.pen), //매너후기
    CustomCircleFilledIcon(Colors.green, CupertinoIcons.calendar), //약속설정
    CustomCircleFilledIcon(Colors.blueAccent, CupertinoIcons.mic), //앱 공지
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'), //채팅, 관심회원등록된 우저, 소식, 이벤트 알림
        centerTitle: true,
      ),

      //공지는 앞에 확성기 아이콘, 활동알림은 앞에 아이콘을 다르게 해서
      // 종류를 파악할 수 있게 처리할 것.
      body: ListView(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                  child: Center(child: entryIcons[2]),
                  backgroundColor: Colors.blue),
              title: Text('${entryText[1]}', maxLines: 2),
              subtitle: Text('1일 전', maxLines: 1),
            ),
          ),
        ],
      ),
    );
  }
}
