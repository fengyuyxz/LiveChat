//
//  WHToast.h
//  WHCommonViewComponents
//
//  Created by Gideon on 2018/6/14.
//  Copyright © 2018年 jinjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView


+ (void)showWithText:(NSString *)text;
+ (void)showWithEnText:(NSString *)text;
+ (void)showInfoWithText:(NSString *)text;//叹号
+ (void)showSuccessWithText:(NSString *)text;//成功

@end
