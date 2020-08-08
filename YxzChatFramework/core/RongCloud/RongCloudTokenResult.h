//
//  RongCloudTokenResult.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/7.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatRoomUserInfoAndTokenModel : NSObject
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,assign)int vip_type;//会员：0：普通会员，1：周会员，2：半年会员，3：年会员
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *imtoken;
@property(nonatomic,copy)NSString *liveroomid;
@end

@interface RongCloudTokenResult : NSObject
@property(nonatomic,assign)int code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)ChatRoomUserInfoAndTokenModel *data;
@end


