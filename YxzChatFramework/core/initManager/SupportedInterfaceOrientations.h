//
//  SupportedInterfaceOrientations.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/30.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SupportedInterfaceOrientations : NSObject
+ (SupportedInterfaceOrientations *)sharedInstance;



//是否开始切换方向 NO时为 之前支持什么就支持什么
@property(nonatomic,assign,readonly)BOOL isSwitchDirection;
@property (assign, nonatomic,readonly) UIInterfaceOrientationMask orientationMask;
-(void)setInterFaceOrientation:(UIInterfaceOrientation)interface;
-(void)beginSupport;
-(void)endSupport;
 
@end

NS_ASSUME_NONNULL_END
