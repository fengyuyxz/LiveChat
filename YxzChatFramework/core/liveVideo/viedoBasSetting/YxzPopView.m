//
//  YxzPopView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/31.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzPopView.h"
#import <Masonry/Masonry.h>
@interface YxzPopView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *animationContainerView;
@property(nonatomic,strong)UIView *supView;

@property(nonatomic,assign)CGRect contextOriginRect;
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic,assign)BOOL showAnimationFinished;
@end
@implementation YxzPopView
-(void)dealloc{
    [self removeGestureRecognizer:self.tapGesture];
    self.tapGesture=nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.45f];
    _tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    _tapGesture.delegate=self;
    [self addGestureRecognizer:_tapGesture];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView=touch.view;
    if (touchView == _contentView||touchView==self.animationContainerView||touchView!=self) {
        return NO;
    }
    for (UIView *subV in self.subviews) {
        if (subV==touchView) {
            return NO;
        }
    }
   
  
    return YES;
}
-(void)tap:(UITapGestureRecognizer *)tap{
    if (self.showAnimationFinished) {
        [self dismiss];
    }
}
-(void)show:(UIView *)contentView superView:(UIView *)supView{
    _contentView=contentView;
    [self.animationContainerView removeFromSuperview];
    self.animationContainerView.frame=CGRectMake(0, CGRectGetHeight(supView.bounds), CGRectGetWidth(supView.bounds), CGRectGetHeight(_contentView.bounds));
    [self.animationContainerView addSubview:_contentView];
    
    [self.animationContainerView addSubview:_contentView];
    
    [self addSubview:self.animationContainerView];
    [self removeFromSuperview];
    [supView addSubview:self];
    _supView=supView;
    self.alpha=0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            self.animationContainerView.frame=CGRectMake(0, CGRectGetHeight(supView.bounds)-CGRectGetHeight(self.contentView.bounds), CGRectGetWidth(supView.bounds), CGRectGetHeight(self.contentView.bounds));
        } completion:^(BOOL finished) {
            self.showAnimationFinished=YES;
        }];
    }];
    
}
-(void)dismiss{
    self.showAnimationFinished=NO;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.animationContainerView.frame=CGRectMake(0, CGRectGetHeight(self.supView.bounds)+CGRectGetHeight(self.contentView.bounds), CGRectGetWidth(self.supView.bounds), CGRectGetHeight(self.contentView.bounds));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            for (UIView *subView in self.animationContainerView.subviews) {
                [subView removeFromSuperview];
            }
            [self removeFromSuperview];
            self.contentView=nil;
            self.supView=nil;
        }];
    }];
}
-(UIView *)animationContainerView{
    if (!_animationContainerView) {
        _animationContainerView=[[UIView alloc]init];
        _animationContainerView.backgroundColor=[UIColor clearColor];
        _animationContainerView.userInteractionEnabled=YES;
    }
    return _animationContainerView;
}
@end
