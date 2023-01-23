import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/app_data/app_name/app_name.dart';
import 'package:mannergamer/utilites/index/index.dart';

class PermissionGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '앱 접근 권한 안내',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                  '${AppName.appName}는 아래 권한들을 필요로 합니다.\n서비스 사용 중 앱에서 요청 시 허용해주세요.'),
              SizedBox(height: 20),
              PermissionItem(
                icon: Icon(
                  CupertinoIcons.photo,
                  size: 30,
                ),
                permissionName: '사진(선택)',
                guideContent: '저장된 사진 중에서 프로필 설정 시 사용',
              ),
              PermissionItem(
                icon: Icon(
                  CupertinoIcons.camera,
                  size: 30,
                ),
                permissionName: '카메라(선택)',
                guideContent: '기본 카메라로 촬영하여 프로필 설정 시 사용',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFullTextButton(
        '확인',
        () async {
          // 알림 권한 요청
          await Permission.notification.request();
          // 로그인 방식 선택하는 페이지로 이동
          Get.offAll(MainLogoPage());
        },
      ),
    );
  }
}