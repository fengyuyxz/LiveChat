//
//  LiveRoomSettingSeparationView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/31.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YxzPlayerModel.h"
@interface RoomSeparationModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,assign)BOOL isCheck;
@end

@interface LiveRoomSeparationCell : UITableViewCell
@property(nonatomic,strong)RoomSeparationModel *model;
@end



@interface LiveRoomSettingSeparationView : UIView

typedef void(^SeparationCompelation)(NSString *title,NSString *url);
@property(nonatomic,copy)SeparationCompelation block;
@property(nonatomic,strong)YxzPlayerModel *playerModel;
@property(nonatomic,strong)NSArray *dataSouce;
@end


