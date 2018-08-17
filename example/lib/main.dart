import 'package:flutter/material.dart';
import 'package:webview_plugin_modify/webview_scaffold.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final webviewPlugin = WebviewPluginModify.getInstance();

  onPress(){
    webviewPlugin.launch('www.google.com',
        rect: new Rect.fromLTWH(0.0, 10.0, 500.0, 400.0));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WebViewScaffold(
          url: "https://www.google.com",
          enableGeoLocation: true,
          enableJavaScript: true,
          appBar: AppBar(
            title: Text('Webview'),
          ),
        )
    );
  }
}