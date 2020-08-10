//
//  RoomBaseInfo.h
//  YxzChatFramework
//  直播室 基本信息，如包含 推流地址  等
//  Created by 颜学宙 on 2020/7/27.
//  Copyright © 2020 颜学宙. All rights reserved.
//
#import "YxzFaceItem.h"
#import <Foundation/Foundation.h>

@interface RoomPlayUrlModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,assign)int sort;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int is_vip;
@end

@interface LivePayAuth : NSObject
@property(nonatomic,assign)BOOL auth;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *more;
@property(nonatomic,copy)NSString *defaultbg;

@end

@interface RoomBaseInfo : NSObject
@property(nonatomic,assign)int btn_type;//发送按钮样式，1星星，2海豚

@property(nonatomic,assign)int roomId;
@property(nonatomic,copy)NSString * star_id;
@property(nonatomic,copy)NSString * view_num;//播放数
@property(nonatomic,copy)NSString * comment_num;//评论数
@property(nonatomic,copy)NSString * zan_num;//点赞数

@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,assign)int is_sole;


@property(nonatomic,copy)NSString *payLiveUrl;
@property(nonatomic,strong)NSArray<RoomPlayUrlModel *> *playList;
@property(nonatomic,strong)NSArray<YxzFaceItem *> *faceList;// 表情礼物
@property(nonatomic,strong)LivePayAuth *auth;

@end


@interface LiveRoomInfoModel : NSObject
@property(nonatomic,assign)int code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)RoomBaseInfo *data;

@end
