import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLogic extends GetxController {
  WebViewController controller= WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
    ),
  )
  ;
  @override
  void onReady() {

    String url =Get.arguments;
    print(url);
   controller.loadRequest(Uri.parse(url));
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
