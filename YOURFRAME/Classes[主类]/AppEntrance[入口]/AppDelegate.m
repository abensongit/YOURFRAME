//
//  AppDelegate.m
//  YOURFRAME
//
//  Created by sunshine on 2019/9/30.
//  Copyright © 2019 sunshine. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置离散网络架构
    [CFCAppUtil applicationNetworkManagerSetting];
    
    // 设置根部窗口
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [self.window setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BACKGROUND_DEFAULT];
    [self.window makeKeyAndVisible];
    
    ViewController *rootViewController = [[ViewController alloc] init];
    [self.window setRootViewController:rootViewController];
    
    return YES;
}

@end
