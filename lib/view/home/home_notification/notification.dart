import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mannergamer/controller/notification/notification.dart';
import 'package:mannergamer/utilites/index/index.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NtfController _ntf = Get.put(NtfController());

  /* 아이콘 조건식
  * 리뷰, 약속, 게시글 관심, 앱 공지 알림 타입에 대한 */
  CustomCircleFilledIcon iconByType(ntfType) {
    // 1. 매너후기
    if (ntfType == 'review') {
      return CustomCircleFilledIcon(Colors.yellow, CupertinoIcons.pen);
    }
    // 2. 약속설정
    else if (ntfType == 'appoint') {
      return CustomCircleFilledIcon(Colors.green, CupertinoIcons.calendar);
    }
    // 3. 게시글 관심
    else if (ntfType == 'favorite') {
      return CustomCircleFilledIcon(Colors.red, CupertinoIcons.heart);
    }
    // 4. 앱 공지 및 마케팅
    else {
      return CustomCircleFilledIcon(Colors.blueAccent, CupertinoIcons.mic);
    }
  }

  /* 알림 타입에 따른 알림 내용 텍스트에 대한 조건식 */
  String contentByType(ntfType, userName, postTitle, content) {
    // 1. 매너후기
    if (ntfType == 'review') {
      return '"$userName님"이 "$postTitle"의 매너 후기를 남겼어요.';
    }
    // 2. 약속설정
    else if (ntfType == 'appoint') {
      return '"$userName님"이 "$postTitle"의 약속을 설정했어요.';
    }
    // 3. 게시글 관심
    else if (ntfType == 'favorite') {
      return '$userName님이 "$postTitle"을 관심게시글로 등록했어요.';
    }
    // 4. 앱 공지 및 마케팅
    else {
      return '$content';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
          physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
          itemCount: _ntf.ntfList.length,
          itemBuilder: (BuildContext context, int index) {
            //날짜 형식 변환 '-전'
            final String _time =
                Jiffy(_ntf.ntfList[index].createdAt.toDate()).fromNow();
            //타입
            final String _type = _ntf.ntfList[index].type;
            //내용
            final String _content = _ntf.ntfList[index].content ?? '';
            //유저이름
            final String _userName = _ntf.ntfList[index].userName;
            //게시글 제목
            final String _title = _ntf.ntfList[index].postTitle;

            return
                // Slidable(
                //   endActionPane: ActionPane(
                //     motion: DrawerMotion(),
                //     extentRatio: 0.2,
                //     children: [
                //       SlidableAction(
                //         onPressed: (_) {},
                //         backgroundColor: Color(0xFFFE4A49),
                //         foregroundColor: Colors.white,
                //         icon: Icons.delete,
                //         label: '삭제',
                //       ),
                //     ],
                //   ),
                //   child:
                ListTile(
              minLeadingWidth: 0,
              isThreeLine: true,
              minVerticalPadding: 15,
              onTap: () {},
              /* 아이콘 */
              leading: CircleAvatar(
                  child: Center(
                    child: iconByType(_type),
                  ),
                  backgroundColor: Colors.blue),
              /* 알림 내용 */
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  contentByType(
                    _type,
                    _userName,
                    _title,
                    _content,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  // maxLines: 2, //멕스라인은 정하지 않기로 함
                ),
              ),
              /* 날짜표시 */
              subtitle: Text(
                _time,
                style: TextStyle(fontSize: 14),
                maxLines: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
