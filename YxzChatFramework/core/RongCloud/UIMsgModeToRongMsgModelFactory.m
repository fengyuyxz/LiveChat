//
//  UIMsgModeToRongMsgModelFactory.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "UIMsgModeToRongMsgModelFactory.h"
#import "NSString+Empty.h"
@implementation UIMsgModeToRongMsgModelFactory
+(RCMessageContent *)uiMsgModelToRCMsgModel:(YXZMessageModel *)message{
    RCMessageContent *messageContent=[[RCMessageContent alloc]init];
    messageContent.senderUserInfo=[RCIMClient sharedRCIMClient].currentUserInfo;
    NSString *msg=![NSString isEmpty:message.content]?message.content:@"";
    if (message.msgType==YxzMsgType_barrage) {
        if (![NSString isEmpty:message.faceImageUrl]) {
            msg=[msg stringByAppendingFormat:@"[%@]",message.faceImageUrl];
        }
    }
    
    messageContent.rawJSONData=[msg dataUsingEncoding:NSUTF8StringEncoding];
    return messageContent;
}
@end
