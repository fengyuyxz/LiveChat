//
//  UIMsgModeToRongMsgModelFactory.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCMessageModel.h"
#import "JoinRoomMsg.h"
#import "YXZMessageModel.h"
#import "PraiseMessagModel.h"
#import <RongIMLib/RongIMLib.h>
@interface UIMsgModeToRongMsgModelFactory : NSObject

/// 消息展示model 转融云消息model
/// @param uiMsg 展示msg model
+(RCMessageContent *)uiMsgModelToRCMsgModel:(YXZMessageModel *)uiMsg;

/// 融云消息model 转 ui model
/// @param rcMsg 融云msg model
+(YXZMessageModel *)rcMsgModeToUiMsgModel:(RCMessageContent *)rcMsg;
@end


