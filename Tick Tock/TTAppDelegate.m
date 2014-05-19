#import "TTAppDelegate.h"

#import "TTClockViewController.h"

@interface TTAppDelegate ()

@property (nonatomic, strong) TTClockViewController *clockViewController;

@end

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.clockViewController = [TTClockViewController new];
    self.window.rootViewController = self.clockViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
