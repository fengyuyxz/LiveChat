//
//  YxzVideoLooksBasicInoView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/26.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzVideoLooksBasicInfoView.h"
#import "YXZConstant.h"
#import <Masonry/Masonry.h>

#import "NSString+Empty.h"
@interface YxzVideoLooksBasicInfoView()

@property(nonatomic,strong)UIView *playStyleView;
@property(nonatomic,strong)UILabel *playStyleLabel;

@property(nonatomic,strong)UILabel *roomNameLabel;//播放室名称

@property(nonatomic,strong)UIImageView *playTimesImageView;//播放次数或在线人数imageView
@property(nonatomic,strong)UIImageView *likeImage;//收藏 或点赞数码
@property(nonatomic,strong)UIImageView *giveAGiftImageView;//收到礼物

@property(nonatomic,strong)UILabel *playTimesLabel;//播放次数或在线人数imageView
@property(nonatomic,strong)UILabel *likeLabel;//收藏 或点赞数码
@property(nonatomic,strong)UILabel *giveAGiftLabel;//收到礼物



@end
@implementation YxzVideoLooksBasicInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.backgroundColor=baseBlackColor;
    
    UIView *topView=[[UIView alloc]init];
    UIView *bottomView=[[UIView alloc]init];
    [self addSubview:topView];
    [self addSubview:bottomView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.height.equalTo(topView.mas_height);
        make.left.bottom.right.equalTo(self);
    }];
    
    
    [topView addSubview:self.playStyleView];
    [self.playStyleView addSubview:self.playStyleLabel];
    [topView addSubview:self.roomNameLabel];
    [self.playStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView.mas_left).offset(10);
    }];
    [self.playStyleLabel setContentHuggingPriority:256 forAxis:UILayoutConstraintAxisHorizontal];
    [self.playStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playStyleView.mas_left).offset(5);
        make.right.equalTo(self.playStyleView.mas_right).offset(-5);
        make.top.equalTo(self.playStyleView.mas_top).offset(2);
        make.bottom.equalTo(self.playStyleView.mas_bottom).offset(-2);
    }];
    [self.roomNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(self.playStyleView.mas_right).offset(10);
        make.right.equalTo(topView.mas_right).offset(-70);
    }
     ];
    [bottomView addSubview:self.playTimesImageView];
    [bottomView addSubview:self.playTimesLabel];
    [bottomView addSubview:self.likeImage];
    [bottomView addSubview:self.likeLabel];
    [bottomView addSubview:self.giveAGiftImageView];
    [bottomView addSubview:self.giveAGiftLabel];
    
    [self.playTimesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.width.height.equalTo(@(15));
    }];
    [self.playTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(self.playTimesImageView.mas_right).offset(10);
    }];
    
    [self.likeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(self.playTimesLabel.mas_right).offset(10);
        make.width.height.equalTo(@(15));
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(bottomView.mas_centerY);
           make.left.equalTo(self.likeImage.mas_right).offset(10);
           
    }];
    
    [self.giveAGiftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(self.likeLabel.mas_right).offset(10);
           make.width.height.equalTo(@(15));
       }];
    [self.giveAGiftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.equalTo(bottomView.mas_centerY);
              make.left.equalTo(self.giveAGiftImageView.mas_right).offset(10);
              
       }];
    
}
-(void)roomTitle:(NSString *)roomTitle viewNum:(NSString *)viewNum zanNum:(NSString *)zanNum commentNum:(NSString *)commentNum{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.roomNameLabel.text=[NSString isEmpty:roomTitle]?@"":roomTitle;
        self.playTimesLabel.text=[NSString isEmpty:viewNum]?@"":viewNum;
        self.likeLabel.text=[NSString isEmpty:zanNum]?@"":zanNum;
        self.giveAGiftLabel.text=[NSString isEmpty:commentNum]?@"":commentNum;
    });
    
}
-(UILabel *)generateLabel{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"0";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor whiteColor];
    return  label;
}
-(UILabel *)playTimesLabel{
    if (!_playTimesLabel) {
        _playTimesLabel=[self generateLabel];
    }
    return _playTimesLabel;
}
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel=[self generateLabel];
    }
    return _likeLabel;
}
-(UILabel *)giveAGiftLabel{
    if (!_giveAGiftLabel) {
        _giveAGiftLabel=[self generateLabel];
    }
    return _giveAGiftLabel;
}
-(UIImageView *)playTimesImageView{
    if (!_playTimesImageView) {
        _playTimesImageView=[[UIImageView alloc]init];
        _playTimesImageView.image=YxzSuperPlayerImage(@"xiaobofan");
    }
    return _playTimesImageView;
}
-(UIImageView *)likeImage{
    if (!_likeImage) {
        _likeImage=[[UIImageView alloc]init];
        _likeImage.image=YxzSuperPlayerImage(@"shoucang");
    }
    return _likeImage;
}
-(UIImageView *)giveAGiftImageView{
    if (!_giveAGiftImageView) {
        _giveAGiftImageView=[[UIImageView alloc]init];
        _giveAGiftImageView.image=YxzSuperPlayerImage(@"pinglun");
    }
    return _giveAGiftImageView;
}
-(UILabel *)playStyleLabel{
    if (!_playStyleLabel) {
        _playStyleLabel=[self generateLabel];
        _playStyleLabel.textColor=RGBA_OF(0XEB5A58);
        _playStyleLabel.text=@"· Live";
    }
    return _playStyleLabel;
}
-(UIView *)playStyleView{
    if (!_playStyleView) {
        _playStyleView=[[UIView alloc]init];
        _playStyleView.backgroundColor=[UIColor blackColor];
    }
    return _playStyleView;
}
-(UILabel *)roomNameLabel{
    if (!_roomNameLabel) {
        _roomNameLabel=[[UILabel alloc]init];
        _roomNameLabel.textColor=[UIColor whiteColor];
        _roomNameLabel.font=[UIFont systemFontOfSize:15];
        _roomNameLabel.text=@"";
    }
    return _roomNameLabel;
    
}
@end
