//
//  YxzLiveRoomSettingView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/30.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzLiveRoomSettingView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YXZConstant.h"
#import "NSString+Empty.h"
@interface YxzLiveRoomSettingView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)LiveRoomSettingHeadeView *headerView;
@end
@implementation YxzLiveRoomSettingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setHeader:(RoomSettingHeadeModel *)model sharpness:(NSString *)sharpness{
    self.headerView.headeModel=model;
    _dataSouce=[[NSMutableArray alloc]init];
    RoomSettingModel *sharpnesM=[[RoomSettingModel alloc]init];
    sharpnesM.title=@"分辨率";
    sharpnesM.logImg=@"setting";
    if (![NSString isEmpty:sharpness]) {
        sharpnesM.subTitle=sharpness;
    }
    [_dataSouce addObject:sharpnesM];

    RoomSettingModel *shareM=[[RoomSettingModel alloc]init];
    shareM.title=@"分享";
    shareM.logImg=@"share";
    [_dataSouce addObject:shareM];
//    RoomSettingModel *jubaoM=[[RoomSettingModel alloc]init];
//    jubaoM.title=@"举报";
//    jubaoM.logImg=@"jubao";
//    [_dataSouce addObject:jubaoM];
    [self.tableView reloadData];
}
-(void)setupView{
    self.userInteractionEnabled=YES;
    self.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.tableView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
//        make.height.equalTo(self.mas_height).multipliedBy(0.45);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.containerView);
    }];
    self.headerView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    self.tableView.tableHeaderView=self.headerView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.headerView.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, 64);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSouce) {
        return self.dataSouce.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveRoomSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LiveRoomSettingCell"];
    RoomSettingModel *model=self.dataSouce[indexPath.row];
    cell.settingModel=model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=indexPath.row;
    LiveRoomSeetingEnum sett=liveRoomSeeting_separation;
    if (row==0) {
        sett=liveRoomSeeting_separation;
    }else if(row==1){
        sett=liveRoomSeeting_share;
    }else if (row==2){
        sett=liveRoomSeeting_report;
    }
    if (self.block) {
        self.block(sett);
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
       _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor=baseBlackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled=YES;
        //_tableView.estimatedRowHeight = 40;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive|UIScrollViewKeyboardDismissModeOnDrag;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionFooterHeight = 0;
//        _tableView.sectionHeaderHeight = 0;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LiveRoomSettingCell class] forCellReuseIdentifier:@"LiveRoomSettingCell"];
    
    }
    return _tableView;
}
-(LiveRoomSettingHeadeView *)headerView{
    if (!_headerView) {
        _headerView=[[LiveRoomSettingHeadeView alloc]init];
    }
    return _headerView;
}
-(UIView *)containerView{
    if (!_containerView) {
        _containerView=[[UIView alloc]init];
        _containerView.backgroundColor=baseBlackColor;
        _containerView.userInteractionEnabled=YES;
    }
    return _containerView;
}
@end

//=======================  setting cell =======================
@interface LiveRoomSettingCell()
@property (nonatomic,strong)UIImageView *logImageView;
@property (nonatomic,strong)UILabel *mTitleLable;
@property (nonatomic,strong)UILabel *subTitleLabel;
@end
@implementation LiveRoomSettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor=baseBlackColor;
    [self addSubview:self.logImageView];
    [self addSubview:self.mTitleLable];
    [self addSubview:self.subTitleLabel];
    
    [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(25);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    [self.mTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        
        make.left.equalTo(self.logImageView.mas_right).offset(15);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        
        make.left.equalTo(self.mTitleLable.mas_right).offset(10);
    }];
}
-(void)setSettingModel:(RoomSettingModel *)settingModel{
    _settingModel=settingModel;
    self.logImageView.image=YxzSuperPlayerImage(settingModel.logImg);
    self.mTitleLable.text=settingModel.title;
    self.subTitleLabel.text=settingModel.subTitle?settingModel.subTitle:@"";
}
-(UIImageView *)logImageView{
    if (!_logImageView) {
        _logImageView=[[UIImageView alloc]init];
    }
    return _logImageView;
}
-(UILabel *)mTitleLable{
    if (!_mTitleLable) {
        _mTitleLable=[[UILabel alloc]init];
        _mTitleLable.font=[UIFont systemFontOfSize:15];
        _mTitleLable.textColor=[UIColor whiteColor];
    }
    return _mTitleLable;
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel=[[UILabel alloc]init];
        _subTitleLabel.font=[UIFont systemFontOfSize:12];
        _subTitleLabel.textColor=RGBAOF(0x757579,1);
    }
    return _subTitleLabel;
}
@end

@interface LiveRoomSettingHeadeView()
@property(nonatomic,strong)UIImageView *headImageView;//头像
@property(nonatomic,strong)UILabel *userTitle;
@property(nonatomic,strong)UILabel *userSubTitle;
@end
@implementation LiveRoomSettingHeadeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self layoutSubViewConstraint];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
        [self layoutSubViewConstraint];
    }
    return self;
}

-(void)setupView{
    [self addSubview:self.headImageView];
    [self addSubview:self.userTitle];
    [self addSubview:self.userSubTitle];
    UIView *liveView=[[UIView alloc]init];
    liveView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.35f];
    [self addSubview:liveView];
    [liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.4);
    }];
}
-(void)layoutSubViewConstraint{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    [self.userTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(5);
        make.bottom.equalTo(self.mas_centerY).offset(1);
    }];
    [self.userSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(5);
        make.top.equalTo(self.mas_centerY);
    }];
    
}
-(void)setHeadeModel:(RoomSettingHeadeModel *)headeModel{
    _headeModel=headeModel;
    NSURL *url=[NSURL URLWithString:_headeModel.headerImgUrlStr];
    [self.headImageView sd_setImageWithURL:url placeholderImage:YxzSuperPlayerImage(@"morentouxiang")];
    self.userTitle.text=_headeModel.m_title?_headeModel.m_title:@"";
    self.userSubTitle.text=_headeModel.s_title?_headeModel.s_title:@"";
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.clipsToBounds=YES;
        _headImageView.layer.cornerRadius=20;
    }
    return _headImageView;
}
-(UILabel *)userTitle{
    if (!_userTitle) {
        _userTitle=[[UILabel alloc]init];
        _userTitle.font=[UIFont systemFontOfSize:15];
        _userTitle.textColor=[UIColor whiteColor];
    }
    return _userTitle;
}
-(UILabel *)userSubTitle{
    if (!_userSubTitle) {
        _userSubTitle=[[UILabel alloc]init];
        _userSubTitle.font=[UIFont systemFontOfSize:11];
        _userSubTitle.textColor=RGBA_OF(0x757579);
    }
    return _userSubTitle;
}
@end

@implementation RoomSettingModel

@end
@implementation RoomSettingHeadeModel
@end
