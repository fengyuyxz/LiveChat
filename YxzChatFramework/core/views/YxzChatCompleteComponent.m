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
@property(nonatomic,strong)YxzUserModel *userModel;
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
    [self addSubview:_inputboxView];
    
    [self addSubview:self.firworkBut];
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
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
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
    self.praiseAnimateManager.startPoint=CGPointMake(self.firworkBut.center.x, self.firworkBut.frame.origin.y-25);
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
-(void)joinRoom:(ChatRoomUserInfoAndTokenModel *)model userToken:(NSString *)userToken{
    _tokenModel=model;
    __weak typeof(self) weakSelf =self;
    [[RongCloudManager shareInstance]connectRongCloudService:model.imtoken userToken:userToken completion:^(BOOL isConnect, NSString *userId) {
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
    [[RongCloudManager shareInstance]sendMessage:model compleiton:^(BOOL isSUC, NSString *messageId) {
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
    NSLog(@"烟花");
//   NSString *typeNum= [YxzAnimationControl generateAnimationNums];
//    [YxzAnimationControl beginAnimation:typeNum animationImageView:self.animationView];
    self.praiseAnimateManager.x_left_swing=30;
    self.praiseAnimateManager.x_right_swing=15;
    self.praiseAnimateManager.animation_h=self.animationView.frame.size.height;
    self.praiseAnimateManager.speed=1;
//    [self.praiseAnimateManager animate:2];
    [self.praiseAnimateManager starAnimation:10];
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
-(UIButton *)firworkBut{
    if (!_firworkBut) {
           _firworkBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_firworkBut setImage:YxzSuperPlayerImage(@"fireworks") forState:UIControlStateNormal];
        [_firworkBut addTarget:self action:@selector(firworkButPressed:) forControlEvents:UIControlEventTouchUpInside];
       }
    return _firworkBut;
}
-(UIView *)animationView{
    if (!_animationView) {
        _animationView=[[UIImageView alloc]init];
        for(int i=0;i<6;i++){
            UIImageView *imgView=[[UIImageView alloc]init];
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
