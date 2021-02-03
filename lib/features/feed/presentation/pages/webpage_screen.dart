import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageScreen extends StatefulWidget {
  final String title;
  final String url;
  const WebPageScreen({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebPageScreenState createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:  widget.title.text.xl.extraBold.black.make(),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (p){
          // context.showToast(msg: p);
        },
        onPageStarted: (p){
          // context.showToast(msg: p);
        },
        onWebResourceError: (e){
          context.showToast(msg: "error ${e.description}");
        },
      ),
    );
  }
}
