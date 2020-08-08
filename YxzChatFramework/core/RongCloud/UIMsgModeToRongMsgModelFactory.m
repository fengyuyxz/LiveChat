//
//  UIMsgModeToRongMsgModelFactory.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "UIMsgModeToRongMsgModelFactory.h"
#import <MJExtension/MJExtension.h>

#import "NSString+Empty.h"
@implementation UIMsgModeToRongMsgModelFactory
+(RCMessageContent *)uiMsgModelToRCMsgModel:(YXZMessageModel *)message{
    RCMessageModel *messageContent=[[RCMessageModel alloc]init];
    messageContent.senderUserInfo=[RCIMClient sharedRCIMClient].currentUserInfo;
    messageContent.senderUserInfo.extra=[NSString stringWithFormat:@"%ld",(long)message.user.level];
    NSString *msg=![NSString isEmpty:message.content]?message.content:@"";
    if (message.msgType==YxzMsgType_barrage) {
        if (![NSString isEmpty:message.faceImageUrl]) {
            msg=[msg stringByAppendingFormat:@"[%@]",message.faceImageUrl];
        }
    }
    NSMutableDictionary *context=[@{@"msgType":@(message.msgType),@"context":msg} mutableCopy];
 
    messageContent.context=context;
    return messageContent;
}
+(YXZMessageModel *)rcMsgModeToUiMsgModel:(RCMessageModel *)rcMsg{
    YXZMessageModel *model=[[YXZMessageModel alloc]init];
    NSDictionary *dic=rcMsg.context;
    YxzUserModel *user=[YxzUserModel new];
    user.userID=rcMsg.senderUserInfo.userId;
    user.nickName=rcMsg.senderUserInfo.name;
    if (![NSString isEmpty:rcMsg.senderUserInfo.extra]) {
        @try {
            user.level=[rcMsg.senderUserInfo.extra intValue];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    if (dic) {
        if ([dic objectForKey:@"msgType"]) {
            model.msgType=[(NSNumber *)dic[@"msgType"] intValue];
        }
        
    }
    model.user=user;
    return model;
}
@end
