import 'package:mannergamer/utilites/index.dart';

class Homepage extends StatelessWidget {
  //Get controller instance 생성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HomeDropDownButton(),
        actions: [
          IconButton(
            onPressed: () => {Get.toNamed('/search')},
            icon: Icon(Icons.search_sharp), //홈 앱바의 오른쪽 메뉴버튼, 선택시 게임종류 선택창 출력
          ),
          IconButton(
            onPressed: () => {Get.toNamed('/ntf')},
            icon: Icon(Icons
                .notifications_none_outlined), //아이콘에 알림개수 표시, 클릭시 : 알림목록 페이지 출력
          ),
        ],
      ),
      body: HomePostList(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.toNamed('/addPost');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
