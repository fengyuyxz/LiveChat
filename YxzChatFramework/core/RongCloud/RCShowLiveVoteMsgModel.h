//
//  RCShowLiveVoteMsgModel.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#import "VoteItemModelResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface RCShowLiveVoteMsgModel : RCMessageContent
@property(nonatomic,strong)VoteItemModelResult *context;
@end

NS_ASSUME_NONNULL_END
