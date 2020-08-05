//
//  NSString+Empty.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/25.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Empty)
//判断字符串是否非空
+ (BOOL)isEmpty:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
