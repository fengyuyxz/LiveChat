//
//  LoadLiveInfoManager.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/5.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomBaseInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoadLiveInfoManager : NSObject
typedef void(^loadLiveInfoCompletion)(BOOL rsult,LiveRoomInfoModel *info);
-(void)loadLiveInfo:(NSString *)userToken liveId:(NSString *)liveId completion:(loadLiveInfoCompletion)block;
@end

NS_ASSUME_NONNULL_END
