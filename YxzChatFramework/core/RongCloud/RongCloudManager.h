//
//  RongCloudManager.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/7.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RongCloudTokenResult.h"
#import "RCLiveVoteMsgModel.h"
#import <RongIMLib/RongIMLib.h>
#import "UIMsgModeToRongMsgModelFactory.h"
#import "YXZMessageModel.h"
#import "PraiseMessagModel.h"
#import "VoteItemModelResult.h"
#import "BackgroundAnimationMessage.h"
@protocol RongCouldManagerReciveDelegate <NSObject>

-(void)reciveRCMessage:(YXZMessageModel *)model;

-(void)prasieAnmiaiton:(PraiseMessagModel *)model;
-(void)backgroundAnimation:(NSString *)animation;

@end
@protocol RongCouldVoteDelegate <NSObject>

-(void)voteMsg:(VoteItemModelResult *)voteModel;

@end
///  用于融云sdk 初始化，和连接 加入聊天室 聊天接发消息等
@interface RongCloudManager : NSObject




@property(nonatomic,weak)id<RongCouldManagerReciveDelegate> delegate;
@property(nonatomic,weak)id<RongCouldVoteDelegate> voteDelegate;
@property(nonatomic,copy)NSString *chatRoomId;

+(instancetype)shareInstance;

+(void)loadRongCloudSdk;

/// 加入聊天室
/// @param roomId 聊天室id
/// @param block 回调YES 成功NO 失败 code为融云失败原因code
-(void)joinChatRoom:(NSString *)roomId completion:(void(^)(BOOL joinSuc,RCErrorCode code))block;

/// 退出聊天室
/// @param roomId 聊天室id
/// @param block 回调block
-(void)quitRoom:(NSString *)roomId completion:(void(^)(BOOL joinSuc,RCErrorCode code))block;
// 断开连接
-(void)disConnect;
-(void)setUserId:(NSString *)userId userName:(NSString *)userName;
-(void)getRongCloudTokenWithUserToken:(NSString *)userToken liveId:(NSString *)liveId completion:(void(^)(BOOL isSUC,ChatRoomUserInfoAndTokenModel *model))block;
-(void)connectRongCloudService:(NSString *)token userToken:(NSString *)userToken liveId:(NSString *)liveId  completion:(void(^)(BOOL isConnect,NSString *userId))block;

/// 发送消息
/// @param message 消息列表uimodel 需要转换
/// @param block 消息发送成功失败回调
-(void)sendMessage:(YXZMessageModel *)message compleiton:(void(^)(BOOL isSUC,NSString *messageId))block;

-(void)sendPraiseMessage:(PraiseMessagModel *)message compleiton:(void(^)(BOOL isSUC,NSString *messageId))block;

-(void)sendJoinRoomMssage:(void(^)(BOOL isSUC,NSString *messageId))block;
@end


