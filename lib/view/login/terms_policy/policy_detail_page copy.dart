import 'package:mannergamer/utilites/index/index.dart';

class PrivacyPolicyDetailPage extends StatefulWidget {
  @override
  State<PrivacyPolicyDetailPage> createState() =>
      _PrivacyPolicyDetailPageState();
}

class _PrivacyPolicyDetailPageState extends State<PrivacyPolicyDetailPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // 웹뷰 컨트롤러
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          // 로딩 시
          onProgress: (int progress) {
            CircularProgressIndicator();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },

          // 페이지 에러 시
          onWebResourceError: (WebResourceError error) {
            Center(
              child: Text(
                '페이지를 불러올 수 없습니다.',
                style: TextStyle(
                  // 14-20
                  fontSize: 14.sp,
                  letterSpacing: 0.1.sp,
                  fontWeight: FontWeight.w500,
                  color: appBlackColor,
                ),
              ),
            );
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          UrlLauncher.privacyPolicyUrl,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
