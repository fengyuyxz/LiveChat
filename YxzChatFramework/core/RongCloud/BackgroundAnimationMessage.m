//
//  BackgroundAnimationMessage.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/10.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "BackgroundAnimationMessage.h"

@implementation BackgroundAnimationMessage
+ (NSString *)getObjectName {
  return @"SendAnimation";
}


- (void)decodeWithData:(NSData *)data {
  if (data == nil) {
    return;
  }
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  NSDictionary *json = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (json) {
        self.animation=json[@"animation"];
        NSDictionary *userinfoDic = dictionary[@"user"];
        [self decodeUserInfo:userinfoDic];
    }
    
}
@end
