//
//  YxzAdjustPositionButton.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzAdjustPositionButton.h"

@implementation YxzAdjustPositionButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.midSpacing=8;
        self.imageSize=CGSizeZero;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.midSpacing=8;
               self.imageSize=CGSizeZero;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    if (CGSizeEqualToSize(CGSizeZero, self.imageSize)) {
        [self.imageView sizeToFit];
    }else{
        self.imageView.frame=CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageSize.width, self.imageSize.height);
    }
    self.imageView.clipsToBounds=YES;
    [self.titleLabel sizeToFit];
    switch (self.layoutStyle) {
        case AdjustPositionButtonStyleLeftImageRightTitle:
            [self setlayoutLeftView:self.imageView rightView:self.titleLabel];
            break;
        case AdjustPositionButtonStyleLeftTitleRightImage:
            [self setlayoutLeftView:self.titleLabel rightView:self.imageView];
            break;
        case AdjustPositionButtonStyleeTopImageBottomTitle:
            [self setlayoutTopView:self.imageView bottomView:self.titleLabel];
            break;
        case AdjustPositionButtonStyleTopTitleBottomImage:
            [self setlayoutTopView:self.titleLabel bottomView:self.imageView];
            break;
        default:
            break;
    }
}
-(void)setlayoutLeftView:(UIView *)leftView rightView:(UIView *)rightView{
    CGRect leftFrame=leftView.frame;
    CGRect rightFrame=rightView.frame;
    CGFloat totalWidth = CGRectGetWidth(leftFrame)+self.midSpacing+CGRectGetWidth(rightFrame);
    leftFrame.origin.x=(CGRectGetWidth(self.frame)-totalWidth)/2.0f;
    leftFrame.origin.y=CGRectGetHeight(self.frame)/2.0f-CGRectGetHeight(leftFrame)/2.0f;
    rightFrame.origin.x=leftFrame.origin.x+CGRectGetWidth(leftFrame)+self.midSpacing;
    rightFrame.origin.y=CGRectGetHeight(self.frame)/2.0f-CGRectGetHeight(rightFrame)/2.0f;
    
    leftView.frame=leftFrame;
    rightView.frame=rightFrame;
}
-(void)setlayoutTopView:(UIView *)topView bottomView:(UIView *)bottomView{
    CGRect topFrame=topView.frame;
    CGRect bottomFrame=bottomView.frame;
    CGFloat totalHight=CGRectGetHeight(topFrame)+self.midSpacing+CGRectGetHeight(bottomFrame);
    topFrame.origin.y=(CGRectGetHeight(self.frame)-totalHight)/2.0f;
    topFrame.origin.x=CGRectGetWidth(self.frame)/2.0f-CGRectGetWidth(topFrame)/2.0f;
    
    bottomFrame.origin.y=topFrame.origin.y+CGRectGetHeight(topFrame)+self.midSpacing;
    bottomFrame.origin.x=CGRectGetWidth(self.frame)/2.0f-CGRectGetWidth(bottomFrame)/2.0f;
    topView.frame=topFrame;
    bottomView.frame=bottomFrame;
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
     
    [self setNeedsLayout];
}
-(void)setLayoutStyle:(AdjustPositionButtonStyle)layoutStyle{
    _layoutStyle=layoutStyle;
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self setNeedsLayout];
}

- (void)setMidSpacing:(CGFloat)midSpacing {
    _midSpacing = midSpacing;
    
    [self setNeedsLayout];
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    
    [self setNeedsLayout];
}

@end
