//
//  RCMessageModel.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCMessageModel : RCMessageContent
@property(nonatomic,strong)NSDictionary *context;
@end

NS_ASSUME_NONNULL_END
