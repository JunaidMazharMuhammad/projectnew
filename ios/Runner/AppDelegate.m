#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [GMSServices provideAPIKey:@"AIzaSyC_2vdelF5OBkFaphMp265a44jVwcF_eYI"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
