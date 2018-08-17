import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'webview_state.dart';

export 'webview_state.dart';

class WebviewPluginModify {
  static const MethodChannel _channel = const MethodChannel('webview_plugin_modify');

  static WebviewPluginModify  _instance;

  static WebviewPluginModify  getInstance() => _instance ??= WebviewPluginModify ._();

  final _onStateChanged = StreamController<WebViewState>.broadcast();

  WebviewPluginModify._() {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  Future _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'onStateChange':
        _onStateChanged.add(
          WebViewState.fromMap(Map<String, dynamic>.from(call.arguments)),
        );
        break;
    }
    return null;
  }

  Stream<WebViewState> get onStateChange => _onStateChanged.stream;

  Stream<WebViewStateEventClosed> get onCloseEvent =>
      _onStateChanged.stream
          .where((state) => state.event is WebViewStateEventClosed)
          .map((state) => state.event as WebViewStateEventClosed);

  Stream<WebViewStateEventError> get onErrorEvent =>
      _onStateChanged.stream
          .where((state) => state.event is WebViewStateEventError)
          .map((state) => state.event as WebViewStateEventError);

  Future launch(String url, {
    Map<String, String> headers,
    bool enableJavaScript,
    bool enableGeolocation,
    bool clearCache,
    bool clearCookies,
    bool visible,
    Rect rect,
    String userAgent,
    bool enableZoom,
    bool enableLocalStorage,
    bool enableScroll,
    bool enableSwipeToRefresh,
  }) {
    final args = _createParams(
      url,
      headers,
      enableJavaScript,
      enableGeolocation,
      clearCache,
      clearCookies,
      visible,
      rect,
      userAgent,
      enableZoom,
      enableLocalStorage,
      enableScroll,
      enableSwipeToRefresh,
    );

    return _channel.invokeMethod('launch', args);
  }

  Future reload(String url, {
    Map<String, String> headers,
    bool enableJavaScript,
    bool enableGeolocation,
    bool clearCache,
    bool clearCookies,
    bool visible,
    Rect rect,
    String userAgent,
    bool enableZoom,
    bool enableLocalStorage,
    bool enableScroll,
    bool enableSwipeToRefresh,
  }) {
    final args = _createParams(
      url,
      headers,
      enableJavaScript,
      enableGeolocation,
      clearCache,
      clearCookies,
      visible,
      rect,
      userAgent,
      enableZoom,
      enableLocalStorage,
      enableScroll,
      enableSwipeToRefresh,
    );

    return _channel.invokeMethod('reload', args);
  }

  Map<String, dynamic> _createParams(String url,
      Map<String, String> headers,
      bool enableJavaScript,
      bool enableGeolocation,
      bool clearCache,
      bool clearCookies,
      bool visible,
      Rect rect,
      String userAgent,
      bool enableZoom,
      bool enableLocalStorage,
      bool enableScroll,
      bool enableSwipeToRefresh,) {
    final args = <String, dynamic>{
      'url': url,
      'enableJavaScript': enableJavaScript ?? true,
      'enableGeolocaion': enableGeolocation ?? true,
      'clearCache': clearCache ?? false,
      'visible': visible ?? true,
      'clearCookies': clearCookies ?? false,
      'userAgent': userAgent,
      'enableZoom': enableZoom ?? false,
      'enableLocalStorage': enableLocalStorage ?? true,
      'enableScroll': enableScroll ?? true,
      'enableSwipeToRefresh': enableSwipeToRefresh ?? false,
      'headers': headers,
    };

    if (rect != null) {
      args['rect'] = {
        'left': rect.left,
        'top': rect.top,
        'width': rect.width,
        'height': rect.height
      };
    }

    return args;
  }

  Future openUrl(String url, {
    Map<String, String> headers,
  }) =>
      _channel.invokeMethod(
        'openUrl',
        {
          'url': url,
          'headers': headers,
        },
      );

  Future<String> evalJavascript(String code){
    final res = _channel.invokeMethod('eval', {'code': code});
    return res;
  }

  /// Stop loading WebView
  Future stopLoading() => _channel.invokeMethod('stopLoading');

  /// Close the WebView
  Future close() => _channel.invokeMethod('close');

  /// Reloads the WebView.
  Future refresh() => _channel.invokeMethod('refresh');

  /// Checks if WebView has back route
  Future hasBack() => _channel.invokeMethod('hasBack');

  /// Navigates back on the WebView.
  Future back() => _channel.invokeMethod('back');

  /// Checks if WebView has forward route
  Future hasForward() => _channel.invokeMethod('hasForward');

  /// Navigates forward on the WebView.
  Future forward() => _channel.invokeMethod('forward');

  /// Clears all cookies of WebView
  Future clearCookies() => _channel.invokeMethod("clearCookies");

  /// Clears WebView cache
  Future clearCache() => _channel.invokeMethod("clearCache");

  /// Resize WebView
  Future resize(Rect rect) {
    final args = {};
    args['rect'] = {
      'left': rect.left,
      'top': rect.top,
      'width': rect.width,
      'height': rect.height
    };
    return _channel.invokeMethod('resize', args);
  }

  /// Disposes all Streams and closes WebView
  void dispose() async {
    await close();
    _onStateChanged.close();
    _instance = null;
  }
}