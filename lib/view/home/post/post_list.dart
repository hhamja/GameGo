import 'package:mannergamer/utilites/index/index.dart';

class HomePostList extends GetView<HomePostController> {
  HomePostList({Key? key}) : super(key: key);
  final HomePostController _c = Get.put(HomePostController());

  // 드랍다운버튼 선택한 값에 따른 페이지 새로고침
  Future<void> _refreshFromButtonValue() async {
    if (_c.selectedTearValue != '티어') {
      //티어 선택한 경우( = 3개 다 선택한 경우)
      await controller.filterTear(
          _c.selectedModeValue, _c.selectedPositionValue, _c.selectedTearValue);
    } else if (_c.selectedPositionValue != '포지션') {
      //티어 선택 X, 모드와 포지션을 선택한 경우
      await controller.filterPosition(
          _c.selectedModeValue, _c.selectedPositionValue);
    } else if (_c.selectedModeValue != '게임모드') {
      // 티어, 포지션 선택 X, 게임모드만 선택한 경우
      await controller.filterGamemode(_c.selectedModeValue);
    } else {
      // 티어, 포지션, 게임모드 아무것도 선택하지 않은 경우
      await controller.readPostData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //새로고침 시 PostList의 바뀐 값을 반영하여 Ui에 업데이트함
      onRefresh: _refreshFromButtonValue,
      color: appGreyColor,
      //맨 위에 위치시키는 값
      displacement: 0,
      strokeWidth: 1.2.sp,
      child: controller.obx(
        // 값이 없을 때
        onEmpty: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '게시글이 없습니다.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '게시글을 직접 추가해서 최초의 1인이 되어보세요!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        // 에러가 떴을 때
        onError: (error) => Center(
          child: Text(
            error.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // 값이 존재할 때
        (state) => ListView.builder(
          //리스트가 적어도 스크롤 인식 가능
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: controller.postList.length,
          itemBuilder: (BuildContext context, int index) {
            final _profileUrl = controller.postList[index].profileUrl;
            final _userName = controller.postList[index].userName;
            final _title = controller.postList[index].title;
            final _gamemode = controller.postList[index].gamemode;
            final _position = controller.postList[index].position;
            final _tear = controller.postList[index].tear;
            //게시글 생성시간, -전
            String time =
                Jiffy(controller.postList[index].updatedAt.toDate()).fromNow();
            //onTap 함수
            _onTap() {
              Get.toNamed('/postdetail',
                  arguments: {'postId': controller.postList[index].postId});
            }

            return CustomPostListItem(
              // 탈퇴유저의 경우 기본프로필로 불러옴
              _profileUrl,
              _userName,
              _title,
              _gamemode,
              _position,
              _tear,
              time,
              _onTap,
            );
          },
        ),
      ),
    );
  }
}
