//
//  AppDelegate.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "AppDelegate.h"
#import "YxzLevelManager.h"
#import "LivePlayerInitializeController.h"
#import "SupportedInterfaceOrientations.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[YxzLevelManager sharedInstance]setup];
//    [LivePlayerInitializeController loadLivePlayLicenceUrlAndLincenceKey];
    return YES;
}



#pragma mark - InterfaceOrientation //应用支持的方向



- (UIInterfaceOrientationMask)application:(UIApplication *)application
  supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    if ([SupportedInterfaceOrientations sharedInstance].isSwitchDirection) {
        return [SupportedInterfaceOrientations sharedInstance].orientationMask;
    }
        
    return UIInterfaceOrientationMaskPortrait;
}

@end
