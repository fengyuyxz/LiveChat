//
//  RoomBaseInfo.h
//  YxzChatFramework
//  直播室 基本信息，如包含 推流地址  等
//  Created by 颜学宙 on 2020/7/27.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomPlayUrlModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *playUrl;
@end

@interface RoomBaseInfo : NSObject
@property(nonatomic,copy)NSString *payLiveUrl;
@property(nonatomic,strong)NSArray<RoomPlayUrlModel *> *playList;
@end


