//
//  YxzLiveRoomSettingView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/30.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomSettingModel : NSObject
@property(nonatomic,copy)NSString *logImg;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@end

@interface RoomSettingHeadeModel : NSObject
@property(nonatomic,copy)NSString *headerImgUrlStr;
@property(nonatomic,copy)NSString *m_title;
@property(nonatomic,copy)NSString *s_title;
@end

@interface LiveRoomSettingHeadeView : UIView
@property(nonatomic,strong)RoomSettingHeadeModel *headeModel;
@end


@interface LiveRoomSettingCell : UITableViewCell
@property(nonatomic,strong)RoomSettingModel *settingModel;
@end


@interface YxzLiveRoomSettingView : UIView

typedef NS_ENUM(NSUInteger, LiveRoomSeetingEnum) {
     liveRoomSeeting_separation=0,//分辨率
    liveRoomSeeting_share,
    liveRoomSeeting_report,//举报
};
typedef void(^SettingCompelation)(LiveRoomSeetingEnum setting);
@property(nonatomic,strong)NSMutableArray<RoomSettingModel *> *dataSouce;

@property(nonatomic,copy)SettingCompelation block;

-(void)setHeader:(RoomSettingHeadeModel *)model sharpness:(NSString *)sharpness;
@end



