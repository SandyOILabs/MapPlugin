#import "MapPlugin.h"
#if __has_include(<map_plugin/map_plugin-Swift.h>)
#import <map_plugin/map_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "map_plugin-Swift.h"
#endif

@implementation MapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMapPlugin registerWithRegistrar:registrar];
}
@end
