import 'package:mannergamer/utilites/index/index.dart';

class HomePostList extends GetView<PostController> {
  HomePostList({Key? key}) : super(key: key);
  /* 홈 드랍다운버튼 컨트롤러 */
  final HomePageDropDownBTController _ =
      Get.put(HomePageDropDownBTController());

  /* 홈 드랍다운버튼 컨트롤러 */
  final PostController _post = Get.put(PostController());

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
      onEmpty: Center(
        child: Text(
          '게시글이 없습니다.\n 직접 게시글을 만들어 최초의 1인이 되어보세요',
        ),
      ),
      onError: (error) => Center(child: Text(error.toString())),
      (state) => RefreshIndicator(
        //새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
        onRefresh: _refreshFromButtonValue,
        displacement: 0, //맨 위에 위치시키는 값
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(), //리스트가 적어도 스크롤 인식 가능
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
          itemCount: controller.postList.length,
          itemBuilder: (BuildContext context, int index) {
            final _profileUrl = controller.postList[index].profileUrl; //프로필
            final _userName = controller.postList[index].userName; //유저이름
            final _title = controller.postList[index].title; //게시글 제목
            final _gamemode = controller.postList[index].gamemode; //게시글 제목
            final _position = controller.postList[index].position; //게시글 제목
            final _tear = controller.postList[index].tear; //게시글 제목
            String time = Jiffy(controller.postList[index].createdAt.toDate())
                .fromNow(); //게시글 생성시간, -전
            _onTap() {
              Get.toNamed('/postdetail',
                  arguments: {'postId': controller.postList[index].postId});
            } //onTap 함수

            return CustomThreeLineListTile(
              _profileUrl,
              _userName,
              _title,
              _gamemode,
              _position,
              _tear,
              true,
              time,
              _onTap,
            );
          },
        ),
      ),
    );
  }
}
