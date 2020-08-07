//
//  RoomBaseInfo.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/27.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "RoomBaseInfo.h"
@implementation RoomPlayUrlModel


@end
@implementation LivePayAuth



@end
@implementation RoomBaseInfo
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"playList":@"definition",
        @"roomId":@"id",
        @"faceList":@"sticker"
    };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"playList":@"RoomPlayUrlModel",
        @"faceList":@"YxzFaceItem"
    };
}
@end

@implementation LiveRoomInfoModel



@end
