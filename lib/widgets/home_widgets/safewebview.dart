import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafeWebView extends StatelessWidget {
  WebViewController Url=WebViewController();
 SafeWebView({required this.Url});
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: Url);
  }
}
