import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });
// https://coronavirus-scrapy.herokuapp.com/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          initialUrl: new Uri.dataFromString('<html><head><style>body{color: blue !important;}</style></head><body >hello world</body></html>', mimeType: 'text/html').toString(),
          javaScriptMode: JavaScriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
  Future<void> loadHtmlFromAssets(String filename, controller) async {
    controller.loadUrl(Uri.dataFromString('<html><body>hello world</body></html>', mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }
}