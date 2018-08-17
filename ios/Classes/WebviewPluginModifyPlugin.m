#import "WebviewPluginModifyPlugin.h"
#import <webview_plugin_modify/webview_plugin_modify-Swift.h>

@implementation WebviewPluginModifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWebviewPluginModifyPlugin registerWithRegistrar:registrar];
}
@end
