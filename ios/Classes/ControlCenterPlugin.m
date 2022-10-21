#import "ControlCenterPlugin.h"
#if __has_include(<control_center/control_center-Swift.h>)
#import <control_center/control_center-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "control_center-Swift.h"
#endif

@implementation ControlCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftControlCenterPlugin registerWithRegistrar:registrar];
}
@end
