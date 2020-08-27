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
#import "RongCloudManager.h"
#import "FirstVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    FirstVC *vc=[[FirstVC alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=nav;
    
    
    [[YxzLevelManager sharedInstance]setup];
    [RongCloudManager loadRongCloudSdk];
    
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
