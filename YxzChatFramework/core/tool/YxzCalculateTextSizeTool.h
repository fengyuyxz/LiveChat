//
//  YxzCalculateTextSizeTool.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YxzCalculateTextSizeTool : NSObject
+ (CGSize)YYTextLayoutSize:(NSMutableAttributedString *)attribText width:(CGFloat)width minThresholdValueV:(CGFloat)minThresholdValue;
+ (NSMutableAttributedString *)getAttributed:(NSString *)text font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
