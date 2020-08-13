//
//  YxzInputBoxView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzInputBoxView.h"

#import "YXZConstant.h"
#import "YxzCalculateTextSizeTool.h"
#import "UIView+Frame.h"
#import <Masonry/Masonry.h>
#import "YxzFaceContainerView.h"
#import "YxzShowSelectedFaceView.h"
#define MORE_BUT_CONTAINER_WIDTH 50
#define INPUT_CONTAINER_MIN_SPCE 5
#define INPUT_CONTAINER_INNER_MIN_SPCE 4

#define MORE_BUT_WIDTH 30
#define MAX_TEXTVIEW_HEIGHT 104
#define FACE_BUTTON_W 30

@interface YxzInputBoxView()<UITextFieldDelegate,ShowSelectedFaceDelegate,YxzFaceSeletedDelegate>
@property(nonatomic,strong)UIButton *faceBut;
//@property(nonatomic,strong)UIButton *moreBut;
@property(nonatomic,strong)UIButton *sendButton;
@property(nonatomic,strong)UIView *inputContainerView;

@property(nonatomic,assign)CGRect keyboardFrame;
@property(nonatomic,assign)YxzInputStatus lastInputStatus;
@property(nonatomic,assign)CGFloat defaultInputHight;
@property(nonatomic,strong)YxzFaceContainerView *faceContainerView;
@property(nonatomic,strong)YxzShowSelectedFaceView *showSelectedFaceView;

@property(nonatomic,copy)NSString *faceImage;

@end
@implementation YxzInputBoxView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        [self addKeyboardEventListen];
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}
-(void)addKeyboardEventListen{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 键盘的Frame值即将发生变化的时候创建的额监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

-(void)setupSubViews{
    self.userInteractionEnabled=YES;
    self.backgroundColor=[UIColor whiteColor];
    self.inputStatus=YxzInputStatus_nothing;

    
        
    [self addSubview:self.inputContainerView];
    
//    [self addSubview:self.moreBut];
    
    
    [_inputContainerView addSubview:self.textView];
    [_inputContainerView addSubview:self.faceBut];
    [_inputContainerView addSubview:self.sendButton];
    
    
    [self layoutSubViewsConstraint];
  
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
-(void)layoutSubViewsConstraint{
    [self.inputContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(inputBoxDefaultHight));
    }];
    [self.faceBut mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(INPUT_CONTAINER_MIN_SPCE));
        make.centerY.equalTo(self.inputContainerView.mas_centerY);
        make.width.height.equalTo(@(FACE_BUTTON_W));
    }];
    [self.sendButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputContainerView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(0);
        make.width.equalTo(@(MORE_BUT_CONTAINER_WIDTH));
        make.height.equalTo(@(30));
    }];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputContainerView.mas_centerY);
        make.height.equalTo(@(inputBoxDefaultHight));
        make.right.equalTo(self.sendButton.mas_left).offset(0);
        make.left.equalTo(self.faceBut.mas_right).offset(INPUT_CONTAINER_INNER_MIN_SPCE);
    }];
    
}
-(void)setFaceList:(NSArray<YxzFaceItem *> *)faceList{
    self.faceContainerView.faceDataSouce=[NSMutableArray arrayWithArray:faceList];
}
#pragma mark - show face 相关 方法 =============
-(void)showFaceView{
    
    [self addSubview:self.faceContainerView];
    [self.faceContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(self.faceContainerView.faceContainerH));
    }];
}
-(void)hiddenFaceView{
    [self.faceContainerView removeFromSuperview];
}
-(void)displaySelectedFaceView:(NSString *)faceImg{
    if (!self.showSelectedFaceView.superview) {
        if (self.superview) {
            [self.superview addSubview:self.showSelectedFaceView];
            [self.showSelectedFaceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_top);
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.height.equalTo(@(60));
            }];
        }
    }
    self.showSelectedFaceView.imageURLStr=faceImg;
}
-(void)hiddenFace{
    [self endEditing:YES];
    self.faceImage=nil;
    [self.showSelectedFaceView removeFromSuperview];
    [self.faceContainerView removeFromSuperview];
    self.faceBut.selected=NO;
    self.inputStatus=YxzInputStatus_nothing;
    if (self.faceBut.selected) {
        [self faceButPressed:self.faceBut];
    }
    if ([self.delegate respondsToSelector:@selector(inputBoxStatusChange:changeFromStatus:toStatus:changeHight:)]) {
        [self.delegate inputBoxStatusChange:self changeFromStatus:self.lastInputStatus toStatus:self.inputStatus changeHight:inputBoxDefaultHight];
    }
}
-(void)hiddenInput{
    [self endEditing:YES];
    self.inputStatus=YxzInputStatus_nothing;
    if ([self.delegate respondsToSelector:@selector(inputBoxStatusChange:changeFromStatus:toStatus:changeHight:)]) {
        [self.delegate inputBoxStatusChange:self changeFromStatus:self.lastInputStatus toStatus:self.inputStatus changeHight:inputBoxDefaultHight];
    }
}
#pragma mark - 键盘通知事件 ============
-(void)keyboardWillShow:(NSNotification *)notification{
//    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSLog(@"keyboard h = %f",self.keyboardFrame.size.height);
}
-(void)keyboardWillHide:(NSNotification *)notify{
    
    CGFloat hight = inputBoxDefaultHight;
    if (self.inputStatus==YxzInputStatus_keyborad) {
        self.lastInputStatus=self.inputStatus;
        self.inputStatus=YxzInputStatus_nothing;
    }else if(self.inputStatus==YxzInputStatus_showFace){
        hight+=self.faceContainerView.faceContainerH;
    }
    if ([self.delegate respondsToSelector:@selector(inputBoxStatusChange:changeFromStatus:toStatus:changeHight:)]) {
        [self.delegate inputBoxStatusChange:self changeFromStatus:self.lastInputStatus toStatus:self.inputStatus changeHight:hight];
    }
}
-(void)keyboardFrameWillChange:(NSNotification *)notification{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboard h = %f",self.keyboardFrame.size.height);
    if (self.inputStatus==YxzInputStatus_keyborad&&CGRectGetHeight(self.keyboardFrame)<=inputBoxDefaultHight) {
        return;
    }
    else if ((self.inputStatus == YxzInputStatus_showFace)  &&CGRectGetHeight(self.keyboardFrame)<inputBoxDefaultHight) {
          
          return;
          
      }
    CGFloat containerH=CGRectGetHeight(self.inputContainerView.frame)+INPUT_CONTAINER_MIN_SPCE*2;
    CGFloat hight = containerH>inputBoxDefaultHight?containerH:inputBoxDefaultHight;
    
    if (self.inputStatus==YxzInputStatus_keyborad) {
        hight+=CGRectGetHeight(self.keyboardFrame);
    }else if (self.inputStatus==YxzInputStatus_showFace){
        
    }
    
    if ([self.delegate respondsToSelector:@selector(inputBoxStatusChange:changeFromStatus:toStatus:changeHight:)]) {
        [self.delegate inputBoxStatusChange:self changeFromStatus:self.lastInputStatus toStatus:self.inputStatus changeHight:hight];
    }
}
#pragma mark - show face view delegate========
-(void)delSelectedFaceImg{
    self.faceImage=nil;
    [self.showSelectedFaceView removeFromSuperview];
}
-(void)didSelectedFace:(NSString *)imgurl{
    self.faceImage=imgurl;
    [self displaySelectedFaceView:self.faceImage];
}
#pragma mark - textFieldS delegate ========================
- (BOOL)textFieldShouldBeginEditing:(YYTextView *)textView{
    
    self.lastInputStatus=self.inputStatus;
    self.inputStatus=YxzInputStatus_keyborad;
    return YES;
}
-(void)textFieldDidBeginEditing:(YYTextView *)textView{
    self.lastInputStatus=self.inputStatus;
    self.inputStatus=YxzInputStatus_keyborad;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){
//        [self sendCurrentMessage];
        [self sendButtonPressed:self.sendButton];
        return NO;
    }
    return YES;
}

/**
 *  TextView 的输入内容一改变就调用这个方法，
 *
 */
- (void) textViewDidChange:(YYTextView *)textView{
    if ([self.delegate respondsToSelector:@selector(clientInputing:)]) {
           [self.delegate clientInputing:YES];
       }
 
}

-(void)clickFace{
    [self faceButPressed:self.faceBut];
}

-(void)clickTextField{
    [self.textView becomeFirstResponder];
}

#pragma mark - but event  ===============================
-(void)faceButPressed:(UIButton *)but{
    self.lastInputStatus=self.inputStatus;
    but.selected=!but.selected;
    if (but.selected) {
//        self.moreBut.selected=NO;
        self.inputStatus=YxzInputStatus_showFace;
        [self showFaceView];
        [self.textView resignFirstResponder];
        CGFloat hight = inputBoxDefaultHight;
        
        hight+=self.faceContainerView.faceContainerH;
        
        if ([self.delegate respondsToSelector:@selector(inputBoxStatusChange:changeFromStatus:toStatus:changeHight:)]) {
            [self.delegate inputBoxStatusChange:self changeFromStatus:self.lastInputStatus toStatus:self.inputStatus changeHight:hight];
        }
        [self.faceContainerView showFace];
    }else{
        self.inputStatus=YxzInputStatus_keyborad;
        
        [self.textView becomeFirstResponder];
        [self hiddenFaceView];
    }
    
  
}


-(void)sendButtonPressed:(UIButton *)but{
    if ([self.delegate respondsToSelector:@selector(sendText:faceImage:)]) {
        NSString *text=self.textView.text;
        
        [self.delegate sendText:text faceImage:self.faceImage];
    }
    self.faceImage=nil;
    [self.showSelectedFaceView removeFromSuperview];
    self.textView.text=@"";
}
-(void)moreButPressed:(UIButton *)but{
    but.selected=!but.selected;
    if (but.selected) {
        self.faceBut.selected=NO;
        self.inputStatus=YxzInputStatus_showMore;
        [self.textView resignFirstResponder];
        
    }else{
        self.inputStatus=YxzInputStatus_keyborad;
        [self.textView becomeFirstResponder];
    }
    
    if (!but.selected) {
        
    }else{
        
    }

}


#pragma mark -getter ======================
-(UIView *)inputContainerView{
    if (!_inputContainerView) {
        _inputContainerView=[[UIView alloc]init];
//        _inputContainerView.backgroundColor=RGBAOF(0x000000,0.25);
    }
    return _inputContainerView;
}
-(UITextField *)textView{
    if (!_textView) {
        _textView=[[UITextField alloc]init];
        _textView.placeholder=@"点击输入内容...";
        _textView.backgroundColor=[UIColor clearColor];
        _textView.delegate=self;
        _textView.returnKeyType=UIReturnKeySend;
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        
//        [_textView setScrollsToTop:NO];
    }
    return _textView;
}
-(UIButton *)faceBut{
    if (!_faceBut) {
        _faceBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_faceBut setBackgroundImage:YxzSuperPlayerImage(@"faceTool") forState:UIControlStateNormal];
        [_faceBut setBackgroundImage:YxzSuperPlayerImage(@"icon_del") forState:UIControlStateSelected];
        [_faceBut addTarget:self action:@selector(faceButPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceBut;
}
-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:RGBA_OF(0X9A9A9D) forState:UIControlStateNormal];
        _sendButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
-(YxzFaceContainerView *)faceContainerView{
    if (!_faceContainerView) {
        _faceContainerView=[[YxzFaceContainerView alloc]init];
        _faceContainerView.delegate=self;
    }
    return _faceContainerView;
}
-(YxzShowSelectedFaceView *)showSelectedFaceView{
    if (!_showSelectedFaceView) {
        _showSelectedFaceView=[[YxzShowSelectedFaceView alloc]init];
        _showSelectedFaceView.delegate=self;
    }
    return _showSelectedFaceView;
}
/*
-(UIButton *)moreBut{
    if (!_moreBut) {
        _moreBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBut setBackgroundImage:[[YxzGetBundleResouceTool shareInstance]getImageWithImageName:@"moreTool"] forState:UIControlStateNormal];
        [_moreBut setBackgroundImage:[[YxzGetBundleResouceTool shareInstance]getImageWithImageName:@"icon_del"] forState:UIControlStateSelected];
        [_moreBut addTarget:self action:@selector(moreButPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBut;
}*/
@end

