//
//  VoteItemModelResult.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "VoteItemModelResult.h"

@implementation VoteItemModelResult
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"voteId":@"id"};
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"items":@"VoteItemModel",
    };
}
@end
@implementation VoteItemModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"voteId":@"id"};
}

@end
@implementation VoteNetResult



@end
