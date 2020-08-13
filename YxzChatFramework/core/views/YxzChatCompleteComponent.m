//
//  YxzChatCompleteComponent.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzChatCompleteComponent.h"
#import "YxzChatListTableView.h"
#import "RongCloudManager.h"
#import "YXZConstant.h"
#import "YxzAnimationControl.h"
#import "PraiseAnimation.h"
#import <Masonry/Masonry.h>

#define fir_1_but_w (device_sceen_width * 81 /375)
#define fir_1_but_h (fir_1_but_w*52/81)
#define fir_2_but_w (device_sceen_width * 96 /375)
#define fir_2_but_h (fir_2_but_w*49/96)

@interface YxzChatCompleteComponent()<YxzInputViewDelegate,YxzListViewInputDelegate,RoomMsgListDelegate,RongCouldManagerReciveDelegate>
@property(nonatomic,strong)ChatRoomUserInfoAndTokenModel *tokenModel;
@property(nonatomic,strong)YxzChatListTableView *listTableView;
@property(nonatomic,strong)YxzInputBoxView *inputboxView;
@property(nonatomic,assign)CGFloat inputBoxHight;
@property(nonatomic,assign)CGFloat defaultINputBoxHight;

@property(nonatomic,copy)HiddenKeyboardAndFaceViewCompletion hiddenKyboardFaceBlock;

@property(nonatomic,strong)UIView *animationView;

@property(nonatomic,strong)UIButton *firworkBut;
@property(nonatomic,strong)PraiseAnimation *praiseAnimateManager;
@property(nonatomic,strong)PraiseAnimation *dolphinsAnimateManager;//海豚

@property(nonatomic,strong)PraiseAnimation *shootingStarAnimate;

@property(nonatomic,strong)YxzUserModel *userModel;

@property(nonatomic,strong)NSTimer *praiseTimer;
@property(nonatomic,assign)int praiseTimes;
@end
@implementation YxzChatCompleteComponent
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
-(void)setupSubViews{
    self.userInteractionEnabled=YES;
    
    _praiseAnimateManager=[[PraiseAnimation alloc]initWithImageArray:@[YxzSuperPlayerImage(@"icon_xin")] onView:self.animationView startAnimationPoint:self.firworkBut.center];
    
    _dolphinsAnimateManager=[[PraiseAnimation alloc]initWithImageArray:@[YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"icon_xin"),YxzSuperPlayerImage(@"water1"),YxzSuperPlayerImage(@"water2"),YxzSuperPlayerImage(@"water3")] onView:self.animationView startAnimationPoint:self.firworkBut.center];
    
    
    _shootingStarAnimate=[[PraiseAnimation alloc]initWithImageArray:@[YxzSuperPlayerImage(@"star")] onView:self.animationView startAnimationPoint:self.firworkBut.center];
    _shootingStarAnimate.animation_h=250;
    _shootingStarAnimate.speed=1;
    _shootingStarAnimate.x_right_swing=20;
    _shootingStarAnimate.x_right_swing=10;
    
    self.inputBoxHight=inputBoxDefaultHight;
    _listTableView=[[YxzChatListTableView alloc]initWithFrame:CGRectZero];
    _listTableView.delegate=self;
    _listTableView.listInputView.delegate=self;
    _listTableView.reloadType=YxzReloadLiveMsgRoom_Time;
    [self addSubview:self.animationView];
    [self addSubview:_listTableView];
    _inputboxView=[[YxzInputBoxView alloc]initWithFrame:CGRectZero];
    _inputboxView.delegate=self;
    _inputboxView.hidden=YES;
    [self addSubview:self.firworkBut];
    [self addSubview:_inputboxView];
    
    
    [self layoutSubViewConstraint];
    [RongCloudManager shareInstance].delegate=self;
}

-(void)layoutSubViewConstraint{
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.listTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(@(MsgTableViewWidth));
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.inputboxView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(inputBoxDefaultHight);
        make.height.equalTo(@(inputBoxDefaultHight));
    }];
    [self.firworkBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        make.width.mas_equalTo(fir_2_but_w);
        make.height.mas_equalTo(fir_2_but_h);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
}


-(BOOL)isPortrait{
    UIDeviceOrientation orientaition=[UIDevice currentDevice].orientation;
    BOOL flag=YES;
    if (orientaition==UIDeviceOrientationLandscapeLeft||orientaition==UIDeviceOrientationLandscapeLeft) {
        flag=NO;
    }
    return flag;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    [self layoutSubViewConstraint];
//    [self layoutSubViewFrame];
    
    _shootingStarAnimate.animation_h=self.animationView.frame.size.height;
    self.praiseAnimateManager.startPoint=CGPointMake(self.firworkBut.center.x, self.firworkBut.frame.origin.y-25);
    self.dolphinsAnimateManager.startPoint=CGPointMake(self.firworkBut.center.x, self.firworkBut.frame.origin.y-25);
}



-(void)hiddenTheKeyboardAndFace:(HiddenKeyboardAndFaceViewCompletion)block{
    self.hiddenKyboardFaceBlock=block;
    if (self.inputboxView.inputStatus==YxzInputStatus_keyborad) {
         [self.inputboxView hiddenInput];
    }else if(self.inputboxView.inputStatus==YxzInputStatus_showFace){
         [self.inputboxView hiddenFace];
    }else{
        if (self.hiddenKyboardFaceBlock) {
            self.hiddenKyboardFaceBlock();
            self.hiddenKyboardFaceBlock=nil;
        }
    }
   
   
    
}
-(YxzInputStatus)inputStatus{
    return self.inputboxView.inputStatus;
}
-(void)setFaceList:(NSArray<YxzFaceItem *> *)faceList{
    [self.inputboxView setFaceList:faceList];
}
#pragma mark - 加入聊天室
-(void)joinRoom:(ChatRoomUserInfoAndTokenModel *)model userToken:(NSString *)userToken liveId:(NSString *)liveId{
    _tokenModel=model;
    __weak typeof(self) weakSelf =self;
    [[RongCloudManager shareInstance]connectRongCloudService:model.imtoken userToken:userToken liveId:liveId completion:^(BOOL isConnect, NSString *userId) {
        if (isConnect) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[RongCloudManager shareInstance]setUserId:weakSelf.tokenModel.user_id userName:weakSelf.tokenModel.username];
                [[RongCloudManager shareInstance] joinChatRoom: weakSelf.tokenModel.liveroomid completion:^(BOOL joinSuc, RCErrorCode code) {
                    if (joinSuc) {//加入成功
                        [self sendJoinChatMsg];
                    }
                }];
            });
        }
    }];
}
-(void)sendJoinChatMsg{
    YXZMessageModel *model=[YXZMessageModel new];
    model.msgType=YxzMsgType_memberEnter;
//    model.content=msgText;
//    model.faceImageUrl=faceImageUrlStr;
//
    model.user=self.userModel;
    __weak typeof(self) weakSelf =self;
    [[RongCloudManager shareInstance] sendJoinRoomMssage:^(BOOL isSUC, NSString *messageId) {
        model.msgID=messageId;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [model initMsgAttribute];
            [strongSelf.listTableView addNewMsg:model];
        });
    }];
    
}

#pragma mark - 发送烟花 按钮事件 ======
-(void)firworkButPressed:(UIButton *)but{
    _praiseTimes++;
    if (self.btn_type==2) {
//        NSString *typeNum= [YxzAnimationControl generateAnimationNums];
//        [YxzAnimationControl beginAnimation:typeNum animationImageView:self.animationView];
        
        self.dolphinsAnimateManager.x_left_swing=30;
        self.dolphinsAnimateManager.x_right_swing=15;
        self.dolphinsAnimateManager.animation_h=self.animationView.frame.size.height;
        self.dolphinsAnimateManager.speed=1;
        [self.dolphinsAnimateManager animate:2];
    }else if(self.btn_type==1){
           self.praiseAnimateManager.x_left_swing=30;
           self.praiseAnimateManager.x_right_swing=15;
           self.praiseAnimateManager.animation_h=self.animationView.frame.size.height;
           self.praiseAnimateManager.speed=1;
           [self.praiseAnimateManager animate:2];
    }
    
   
//    [self.praiseAnimateManager starAnimation:10];
    [self startCountPraiseTimes];
    
}
-(void)startCountPraiseTimes{
    if (!_praiseTimer) {
        _praiseTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(prasieTime:) userInfo:nil repeats:NO];
    }
}
-(void)prasieTime:(NSTimer *)time{
    [_praiseTimer invalidate];
    _praiseTimer=nil;
    // 发送点赞次数
    PraiseMessagModel *messageModel=[PraiseMessagModel new];
    messageModel.btn_type=self.btn_type;
    messageModel.times=_praiseTimes;
    YXZMessageModel *model=[YXZMessageModel new];
    model.msgType=YxzMsgType_Subscription;
//    model.content=msgText;
    
        model.user=self.userModel;
    
    
    [[RongCloudManager shareInstance]sendPraiseMessage:messageModel compleiton:^(BOOL isSUC, NSString *messageId) {
        model.msgID=messageId;
        [model initMsgAttribute];
        [self.listTableView addNewMsg:model];
    }];
    _praiseTimes=0;
}
-(void)setIsFull:(BOOL)isFull{
    _isFull=isFull;
//    [self.firworkBut mas_updateConstraints:^(MASConstraintMaker *make) {
//        if (_isFull) {
//             make.right.equalTo(self.mas_right).offset(-45);
//        }else{
//             make.right.equalTo(self.mas_right).offset(-30);
//        }
//       
//    }];
}
#pragma mark - YxzListViewInputDelegate =================
-(void)faceClick{
    [self.inputboxView clickFace];
}
-(void)inputClick{
    [self.inputboxView clickTextField];
}
#pragma mark - RoomMsgListDelegate =================
-(void)tapBackgroundView{
    [self.inputboxView hiddenInput];
}
#pragma mark - YxzInputViewDelegate ======================
-(void)inputBoxStatusChange:(YxzInputBoxView *)boxView changeFromStatus:(YxzInputStatus)fromStatus toStatus:(YxzInputStatus)toStatus changeHight:(CGFloat)hight{
    self.inputBoxHight=hight;
    if (toStatus==YxzInputStatus_keyborad||toStatus==YxzInputStatus_showFace) {
        _inputboxView.hidden=NO;
        [self.inputboxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.height.equalTo(@(hight));
        }];
        [self.listTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(hight-inputBoxDefaultHight));
        }];
        [UIView animateWithDuration:.5 animations:^{

            [self layoutIfNeeded];

        }];
        if ([self.delegate respondsToSelector:@selector(showKeyBorad:)]) {
            [self.delegate showKeyBorad:YES];
        }
    }else if (toStatus==YxzInputStatus_nothing){
        _inputboxView.hidden=YES;
        [self.inputboxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(inputBoxDefaultHight);
            make.height.equalTo(@(inputBoxDefaultHight));
        }];
        [self.listTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.bottom.equalTo(self.mas_bottom).offset(0);
               }];
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (self.hiddenKyboardFaceBlock) {
                self.hiddenKyboardFaceBlock();
                self.hiddenKyboardFaceBlock=nil;
            }
        }];
        if ([self.delegate respondsToSelector:@selector(showKeyBorad:)]) {
            [self.delegate showKeyBorad:NO];
        }
    }
}
//发送消息
-(void)sendText:(NSString *)msgText faceImage:(NSString *)faceImageUrlStr{
    
    
    YXZMessageModel *model=[YXZMessageModel new];
        model.msgType=YxzMsgType_barrage;
    model.content=msgText;
    model.faceImageUrl=faceImageUrlStr;
        model.user=self.userModel;
    
    [self sendRongCould:model];
    
}
#pragma mark - delegateRongCouldManagerDelegate
-(void)reciveRCMessage:(YXZMessageModel *)model{
     __weak typeof(self) weakSelf =self;
    
        [model initMsgAttribute];
        [weakSelf.listTableView addNewMsg:model];
    
}
-(void)backgroundAnimation:(NSString *)animation{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
         [weakSelf.shootingStarAnimate starAnimation:50];
    });
   
}
//收到点赞的消息
-(void)prasieAnmiaiton:(PraiseMessagModel *)model{
    YXZMessageModel *message=[UIMsgModeToRongMsgModelFactory rcMsgModeToUiMsgModel:model];
    [message initMsgAttribute];
    [self.listTableView addNewMsg:message];
//    int times=model.times;
//    if (self.btn_type==1) {
//
//
//        NSMutableArray *array=[NSMutableArray array];
//        for (int i=0; i<times; i++) {
//            NSArray *list=[YxzAnimationControl generatteAnimationNumArray];
//            [array addObjectsFromArray:list];
//        }
//        NSString *animationNums= [array componentsJoinedByString:@","];
//        [YxzAnimationControl beginAnimation:animationNums animationImageView:self.animationView];
//    }else if(self.btn_type==2){
//           self.praiseAnimateManager.x_left_swing=30;
//           self.praiseAnimateManager.x_right_swing=15;
//           self.praiseAnimateManager.animation_h=self.animationView.frame.size.height;
//           self.praiseAnimateManager.speed=1;
//           [self.praiseAnimateManager animate:2*times];
//    }
}
-(void)sendRongCould:(YXZMessageModel *)model{
    __weak typeof(self) weakSelf =self;
    [[RongCloudManager shareInstance] sendMessage:model compleiton:^(BOOL isSUC, NSString *messageId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            model.msgID=messageId;
                   [model initMsgAttribute];
                   [weakSelf.listTableView addNewMsg:model];
        });
    }];
}
-(void)inputBoxHightChange:(YxzInputBoxView *)boxView inputViewHight:(CGFloat)inputHight{
    CGRect frame =self.inputboxView.frame;
    frame.size.height=inputHight;
    frame.origin.y=CGRectGetHeight(self.bounds)-inputHight;
    self.inputboxView.frame=frame;
    CGRect listTabeFrame=self.listTableView.frame;
    listTabeFrame.size.height=CGRectGetHeight(self.bounds)-CGRectGetHeight(frame);
    self.listTableView.frame=listTabeFrame;
}
#pragma mark - getter setter ===========
-(void)setBtn_type:(int)btn_type{
    _btn_type=btn_type;
    if (_btn_type==1) {
        [_firworkBut setImage:YxzSuperPlayerImage(@"Group29") forState:UIControlStateNormal];
    }else if (_btn_type==2){
        if (_btn_type==1) {
            [_firworkBut setImage:YxzSuperPlayerImage(@"Group30") forState:UIControlStateNormal];
        }
    }
    
    [self.firworkBut mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        if (_btn_type==1) {
            make.width.mas_equalTo(fir_2_but_w);
            make.height.mas_equalTo(fir_2_but_h);
        }else if(_btn_type==2){
            make.width.mas_equalTo(fir_1_but_w);
            make.height.mas_equalTo(fir_1_but_h);
        }
        
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
}
-(UIButton *)firworkBut{
    if (!_firworkBut) {
           _firworkBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_firworkBut setImage:YxzSuperPlayerImage(@"Group30") forState:UIControlStateNormal];
        [_firworkBut addTarget:self action:@selector(firworkButPressed:) forControlEvents:UIControlEventTouchUpInside];
       }
    return _firworkBut;
}
-(UIView *)animationView{
    if (!_animationView) {
        _animationView=[[UIImageView alloc]init];
        for(int i=0;i<1;i++){
            UIImageView *imgView=[[UIImageView alloc]init];
            imgView.backgroundColor=[UIColor clearColor];
            [_animationView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(_animationView);
            }];
        }
    }
    return _animationView;
}
-(YxzUserModel *)userModel{
    if (!_userModel) {
        _userModel=[[YxzUserModel alloc]init];
    }
    _userModel.userID=self.tokenModel.user_id;
    _userModel.nickName=self.tokenModel.username;
    _userModel.level=self.tokenModel.vip_type;
    return _userModel;
}
@end
