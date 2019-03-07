import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    WebView webView = WebView(
      initialUrl: widget.url,
      onWebViewCreated: (controller){
        _controller = controller;
      },
      javascriptMode: JavascriptMode.unrestricted,
    );

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(
            padding: EdgeInsets.all(0),
            child: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.title),
        ),
        body: Container(
          child: webView,
        ),
      ),
      onWillPop: _willPop,
    );
  }

  Future<bool> _willPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
