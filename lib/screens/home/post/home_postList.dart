import 'package:mannergamer/utilites/index/index.dart';

class HomePostList extends GetView<PostController> {
  HomePostList({Key? key}) : super(key: key);
  /* 홈 드랍다운버튼 컨트롤러 */
  final HomePageDropDownBTController _ =
      Get.put(HomePageDropDownBTController());

  /* 드랍다운버튼 선택한 값에 따른 페이지 새로고침 */
  Future<void> _refreshFromButtonValue() async {
    if (_.selectedTearValue != '티어') {
      await controller.filterTear(
          _.selectedModeValue, _.selectedPositionValue, _.selectedTearValue);
    } //티어 선택한 경우( = 3개 다 선택한 경우)
    else if (_.selectedPositionValue != '포지션') {
      await controller.filterPosition(
          _.selectedModeValue, _.selectedPositionValue);
    } //티어 선택 X, 모드와 포지션을 선택한 경우
    else if (_.selectedModeValue != '게임모드') {
      await controller.filterGamemode(_.selectedModeValue);
    } // 티어, 포지션 선택 X, 게임모드만 선택한 경우
    else {
      await controller.readPostData();
    } //티어, 포지션, 게임모드 아무것도 선택하지 않은 경우
  }

  @override
  Widget build(BuildContext context) {
    print(Get.currentRoute);
    return controller.obx(
      onEmpty: Center(child: Text('텅')),
      onError: (error) => Center(child: Text(error.toString())),
      (state) => RefreshIndicator(
        //새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
        onRefresh: _refreshFromButtonValue,
        displacement: 0, //맨 위에 위치시키는 값
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
          padding: EdgeInsets.only(top: 10),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          },
          itemCount: controller.postList.length,
          itemBuilder: (BuildContext context, int index) {
            String time =
                Jiffy(controller.postList[index].createdAt.toDate()).fromNow();
            return ListTile(
              onTap: () {
                Get.toNamed('/postdetail', arguments: {
                  'index': index,
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        /* 프로필 */
                        CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                              controller.postList[index].profileUrl),
                        ),
                        SizedBox(width: 5),
                        /* 유저이름 */
                        Text(
                          controller.postList[index].userName,
                          style: TextStyle(height: 1.2),
                        ),
                        /* 날짜 */
                        Expanded(
                          child: Text(
                            time,
                            style: TextStyle(height: 1.2, fontSize: 10),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    /* 게시글 제목 */
                    Text(controller.postList[index].title, maxLines: 1),
                  ],
                ),
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: double.minPositive,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* 게임모드 · 포지션 · 티어 */
                      Text(
                        controller.postList[index].gamemode,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        controller.postList[index].position != null
                            ? ' · ${controller.postList[index].position}'
                            : '',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        controller.postList[index].tear != null
                            ? ' · ${controller.postList[index].tear}'
                            : '',
                        style: TextStyle(fontSize: 12),
                      ),
                      // Expanded(child: SizedBox()),
                      // /* 체팅 수 */
                      // Icon(Icons.chat_bubble_outline, size: 15),
                      // Text('1'),
                      // /* 좋아요 수 */
                      // Icon(Icons.favorite_border_outlined, size: 15),
                      // Text('1'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
