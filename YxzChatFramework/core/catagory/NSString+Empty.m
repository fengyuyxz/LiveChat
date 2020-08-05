//
//  NSString+Empty.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/25.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)
+ (BOOL)isEmpty:(NSString *)string{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string != nil && ![@"" isEqualToString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]] && ![@"null" isEqualToString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        return NO;
    }else{
        return YES;
    }
}

@end
