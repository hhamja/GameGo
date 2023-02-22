import 'package:flutter/cupertino.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gamegoapp/utilites/index/index.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NtfController _ntf = Get.put(NtfController());

  @override
  void initState() {
    super.initState();
    _ntf.getNtfList(); //내가 받은 알림 리스트 서버에서 받기
  }

  // 아이콘 조건식
  // 리뷰, 약속, 게시글 관심, 앱 공지 알림 타입에 대한
  NotificationCircleIcon iconByType(ntfType) {
    if (ntfType == 'review') {
      // 매너후기
      return NotificationCircleIcon(mannerReviewNtfColor, CupertinoIcons.pen);
    } else if (ntfType == 'appoint') {
      // 약속설정
      return NotificationCircleIcon(appointNtfColor, CupertinoIcons.calendar);
    } else if (ntfType == 'favorite') {
      // 게시글 관심
      return NotificationCircleIcon(favoriteNtfColor, CupertinoIcons.heart);
    } else {
      // 앱 공지 및 마케팅
      return NotificationCircleIcon(noticeNtfColor, CupertinoIcons.mic);
    }
  }

  // 알림 타입에 따른 알림 내용 텍스트에 대한 조건식
  String contentByType(ntfType, userName, postTitle, content) {
    // 매너후기
    if (ntfType == 'review') {
      return '"$userName"님이 "$postTitle"의 매너 후기를 남겼어요.';
    }
    // 약속설정
    else if (ntfType == 'appoint') {
      return '"$userName"님이 "$postTitle"의 약속을 설정했어요.';
    }
    // 게시글 관심
    else if (ntfType == 'favorite') {
      return '"$userName"님이 "$postTitle"을 관심게시글로 등록했어요.';
    }
    // 앱 공지 및 마케팅
    else {
      return '$content';
    }
  }

  @override
  Widget build(BuildContext context) {
    _ntf.getNtfList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: Text(
          '알림',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          // 리스트가 적어도 스크롤 인식 가능
          physics: AlwaysScrollableScrollPhysics(),

          itemCount: _ntf.ntfList.length,
          itemBuilder: (BuildContext context, int index) {
            // 날짜 형식 변환 '-전'
            final String _time =
                Jiffy(_ntf.ntfList[index].createdAt.toDate()).fromNow();
            // 타입
            final String _type = _ntf.ntfList[index].type;
            // 내용
            final String _content = _ntf.ntfList[index].content;
            return
                // Slidable(
                //   endActionPane: ActionPane(
                //     motion: DrawerMotion(),
                //     extentRatio: 0.2,
                //     children: [
                //       SlidableAction(
                //         onPressed: (_) {},
                //         backgroundColor: Color(0xFFFE4A49),
                //         foregroundColor: appWhiteColor,
                //         icon: Icons.delete,
                //         label: '삭제',
                //       ),
                //     ],
                //   ),
                //   child:

                ListTile(
              minLeadingWidth: 0,
              isThreeLine: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpaceData.screenPadding,
              ),
              minVerticalPadding: AppSpaceData.screenPadding,
              onTap: () {},
              // 아이콘
              leading: iconByType(_type),

              // 알림 내용
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  contentByType(
                    _type,
                    _ntf.ntfList[index].userName,
                    _ntf.ntfList[index].postTitle,
                    _content,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              // 날짜표시
              subtitle: Text(
                _time,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
                  color: appGreyColor,
                ),
                maxLines: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
