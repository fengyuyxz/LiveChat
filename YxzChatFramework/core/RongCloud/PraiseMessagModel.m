//
//  PraiseMessagModel.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/10.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "PraiseMessagModel.h"

@implementation PraiseMessagModel
+ (NSString *)getObjectName {
  return @"Praise";
}

- (NSData *)encode {
  
  NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
   if (self.senderUserInfo) {
       [dataDict setObject:[self encodeUserInfo:self.senderUserInfo] forKey:@"user"];
   }
    
   [dataDict setObject:@(self.btn_type) forKey:@"btn_type"];
    [dataDict setObject:@(self.times) forKey:@"times"];

  NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
  return data;
}

- (void)decodeWithData:(NSData *)data {
  if (data == nil) {
    return;
  }
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  NSDictionary *json = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (json) {
        if ([json objectForKey:@"btn_type"]) {
            self.btn_type=[(NSNumber *)json[@"btn_type"] intValue];
        }
        if ([json objectForKey:@"times"]) {
            self.times=[(NSNumber *)json[@"times"] intValue];
        }
        NSDictionary *userinfoDic = dictionary[@"user"];
        [self decodeUserInfo:userinfoDic];
    }
    
}
@end
