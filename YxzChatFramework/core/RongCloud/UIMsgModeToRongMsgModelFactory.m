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
+(YXZMessageModel *)rcMsgModeToUiMsgModel:(RCMessageContent *)rcMsg{
    YXZMessageModel *model=[[YXZMessageModel alloc]init];
    long long time=[NSDate timeIntervalSinceReferenceDate];
    model.msgID=[NSString stringWithFormat:@"%lld%d%d",time,arc4random_uniform((int)time),arc4random_uniform((int)time)];
    
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
    if([rcMsg isKindOfClass:[RCMessageModel class]]){
        NSDictionary *dic=((RCMessageModel *)rcMsg).context;
        if (dic) {
            if ([dic objectForKey:@"msgType"]) {
                model.msgType=[(NSNumber *)dic[@"msgType"] intValue];
            }
            if([dic objectForKey:@"context"]){
                NSString *context=dic[@"context"];
                if (![NSString isEmpty:context]) {
                    if ([context containsString:@"["]&&[context containsString:@"]"]) {
                        NSRange startIndex=[context rangeOfString:@"["];
                        NSRange endIndex=[context rangeOfString:@"]"];
                        NSRange range=NSMakeRange(startIndex.location+1, endIndex.location-startIndex.location-1);
                       NSString *imageStr= [context substringWithRange:range];
                        NSString *contentStr=[[[context stringByReplacingOccurrencesOfString:imageStr withString:@""] stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                        model.content=contentStr;
                        model.faceImageUrl=imageStr;
                    }
                }
            }
            
        }
    }else if([rcMsg isKindOfClass:[PraiseMessagModel class]]){
        model.msgType=YxzMsgType_Subscription;
    }
    
    model.user=user;
    return model;
}
@end
