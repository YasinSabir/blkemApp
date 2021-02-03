import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:colibri/extensions.dart';
class WebViewScreen extends StatefulWidget {
  final String url;
  final String name;
  const WebViewScreen({Key key, this.url, this.name}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: WebviewScaffold(
        url: widget.url,
        appBar: new AppBar(
          title:  widget.name.toHeadLine6(color: Colors.white),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
      ),
    ));
  }
}
