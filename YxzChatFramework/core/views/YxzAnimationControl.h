//
//  YxzAnimationControl.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/1.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YxzAnimationControl : NSObject
+(NSString *)generateAnimationNums;
+(NSArray *)generatteAnimationNumArray;
+(void)beginAnimation:(NSString *)animationNum animationImageView:(UIView *)animaitnImageView;
@end


