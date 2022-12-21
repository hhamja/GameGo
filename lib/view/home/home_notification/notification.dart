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
        title: const Text('알림'),
        centerTitle: true,
      ),
      body: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
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
              minLeadingWidth: 0,
              isThreeLine: true,
              minVerticalPadding: 15,
              onTap: () {},
              leading: CircleAvatar(
                  child: Center(
                    child: CustomCircleFilledIcon(
                        Colors.red, CupertinoIcons.heart),
                  ),
                  backgroundColor: Colors.blue),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목',
                  style: TextStyle(
                    fontSize: 16,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  // maxLines: 2, //멕스라인은 정하지 않기로 함
                ),
              ),
              /* 날짜표시 */
              subtitle: Text(
                '날짜',
                style: TextStyle(fontSize: 15),
                maxLines: 1,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return CustomDivider();
        },
        itemCount: 1,
      ),
    );
  }
}
