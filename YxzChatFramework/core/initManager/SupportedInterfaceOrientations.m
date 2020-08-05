//
//  SupportedInterfaceOrientations.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/30.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "SupportedInterfaceOrientations.h"

@implementation SupportedInterfaceOrientations

+ (SupportedInterfaceOrientations *)sharedInstance {
    static SupportedInterfaceOrientations *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
//        instance.orientationMask = UIInterfaceOrientationMaskPortrait;  // 默认竖屏
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _orientationMask = UIInterfaceOrientationMaskPortrait;
    }
    return self;
}
 


-(void)setInterFaceOrientation:(UIInterfaceOrientation)interface{
    [self beginSupport];
    _orientationMask=UIInterfaceOrientationMaskPortrait;
    switch (interface) {
        case UIInterfaceOrientationPortrait:
            _orientationMask=UIInterfaceOrientationMaskPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            _orientationMask=UIInterfaceOrientationMaskLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            _orientationMask=UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeRight:
            _orientationMask=UIInterfaceOrientationMaskLandscapeLeft;
             break;
            
        default:
            break;
    }
    NSNumber *orientationValue = [NSNumber numberWithInt:interface];
    [[UIDevice currentDevice] setValue:orientationValue forKey:@"orientation"];
}
 
-(void)beginSupport{
    _isSwitchDirection=YES;
}
-(void)endSupport{
    _isSwitchDirection=NO;
}

@end
