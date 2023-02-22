import 'package:gamegoapp/utilites/index/index.dart';

class TermsDetailPage extends StatefulWidget {
  @override
  State<TermsDetailPage> createState() => _TermsDetailPageState();
}

class _TermsDetailPageState extends State<TermsDetailPage> {
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
                  fontSize: 18,
                  letterSpacing: 0.1,
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
          UrlLauncher.termsUrl,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroudColor,
        automaticallyImplyLeading: false,
        actions: [
          CustomCloseButton(),
        ],
      ),
      body: Container(
        color: appBackgroudColor,
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
