//
//  RCLiveVoteMsgModel.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "RCLiveVoteMsgModel.h"
#import <MJExtension/MJExtension.h>
@implementation RCLiveVoteMsgModel

+ (NSString *)getObjectName {
  return @"LiveVote";
}

- (void)decodeWithData:(NSData *)data {
  if (data == nil) {
    return;
  }
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  NSDictionary *json = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (json) {
        
        self.context=[[VoteItemModelResult class] mj_objectWithKeyValues:json];
        NSDictionary *userinfoDic = dictionary[@"user"];
        [self decodeUserInfo:userinfoDic];
    }
    
}
@end
