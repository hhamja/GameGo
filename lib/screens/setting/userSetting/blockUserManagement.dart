import 'package:mannergamer/utilites/index.dart';

class BlockUserManagement extends StatefulWidget {
  const BlockUserManagement({Key? key}) : super(key: key);

  @override
  State<BlockUserManagement> createState() => _BlockUserManagementState();
}

class _BlockUserManagementState extends State<BlockUserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('차단 유저 관리'),
        centerTitle: true,
      ),
      body: ListView.separated(
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              leading: CircleAvatar(),
              title: Text('${blockUesrList[index]}'),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    visualDensity: VisualDensity.comfortable,
                    backgroundColor: Colors.blue),
                onPressed: () {},
                child: Text(
                  '차단중',
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
          itemCount: blockUesrList.length),
    );
  }
}
