//
//  LoadLiveInfoManager.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/5.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomBaseInfo.h"
#import "VoteItemModelResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoadLiveInfoManager : NSObject
typedef void(^loadLiveInfoCompletion)(BOOL rsult,LiveRoomInfoModel *info);
-(void)loadLiveInfo:(NSString *)userToken liveId:(NSString *)liveId completion:(loadLiveInfoCompletion)block;



-(void)vote:(NSString *)liveId voteId:(int)voteId userToken:(NSString *)userToken completion:(void(^)(BOOL isSUC,VoteNetResult *result))block;
@end

NS_ASSUME_NONNULL_END
