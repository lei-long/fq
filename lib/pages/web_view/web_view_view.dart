import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_view_logic.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  Widget build(BuildContext context) {
    Get.put(WebViewLogic());
    return GetBuilder<WebViewLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
        ),
        body: WebViewWidget(controller: logic.controller),
      );
    });
  }
}
