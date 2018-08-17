import Flutter
import Foundation

class WebviewState{

    private init(){}

    static func onStateChange(_ channel: FlutterMethodChannel,_ data: NSDictionary){
        channel.invokeMethod("onStateChange", arguments: data)
    }

    static func onStateIdle(_ channel: FlutterMethodChannel){
        channel.invokeMethod("onStateChange", arguments: ["event": "idle"])
    }
}