import 'package:mannergamer/utilites/index.dart';

class FavoriteUserManagementPage extends StatefulWidget {
  const FavoriteUserManagementPage({Key? key}) : super(key: key);

  @override
  State<FavoriteUserManagementPage> createState() =>
      _FavoriteUserManagementPageState();
}

class _FavoriteUserManagementPageState
    extends State<FavoriteUserManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('팔로우 유저 관리'),
        centerTitle: true,
      ),
      body: ListView.separated(
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              leading: CircleAvatar(),
              title: Text('${followUesrList[index]}'),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    visualDensity: VisualDensity.comfortable,
                    backgroundColor: Colors.blue),
                onPressed: () {},
                child: Text(
                  '팔로우중',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          },
          itemCount: followUesrList.length),
    );
  }
}
