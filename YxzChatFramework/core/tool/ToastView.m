//
//  WHToast.m
//  WHCommonViewComponents
//
//  Created by Gideon on 2018/6/14.
//  Copyright © 2018年 jinjiang. All rights reserved.
//

#import "ToastView.h"
#import <Masonry/Masonry.h>


typedef NS_ENUM(NSUInteger, WHToastType) {
    WHToastType_none,
    WHToastType_info,
    WHToastType_success
};

@interface ToastView ()

@property(nonatomic,strong)NSString* text;
@property(nonatomic,strong)UILabel* textLabel;
@property(nonatomic,strong)UIButton* contentView;
@property(nonatomic,strong)UIImageView* logoIV;

@property(nonatomic,assign)WHToastType toastType;

@end

@implementation ToastView

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        _toastType = WHToastType_none;
        self.alpha = 0;
        self.layer.cornerRadius = 4;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.shouldRasterize = YES;
        self.layer.masksToBounds = YES;
        
        _contentView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_contentView];
        _contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        [_contentView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _textLabel = [UILabel new];
        [self addSubview:_textLabel];
        _textLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.text = text;
    }
    return self;
}

- (UIImageView *)logoIV {
    if (_logoIV == nil) {
        _logoIV = [UIImageView new];
        [self addSubview:_logoIV];
    }
    return _logoIV;
}

- (void)show {
    UIWindow* keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self];
    CGFloat hight=[UIScreen mainScreen].bounds.size.height/5.0f*2;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(keyWindow.mas_centerX);
        make.top.equalTo(keyWindow.mas_top).offset(hight);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.right.top.bottom.equalTo(self);
        if (self.toastType == WHToastType_none) {
            make.height.equalTo(@40);
        } else {
            make.height.equalTo(@40);
        }
    }];
    if (self.toastType == WHToastType_none) {
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.center.equalTo(self.contentView);
        }];
    }else {
        if (self.toastType == WHToastType_info) {
          
//            self.logoIV.image = [WHImageFromBundle imageWithName:@"icon_info"];
        }else if (self.toastType == WHToastType_success) {
           
//            self.logoIV.image = [WHImageFromBundle imageWithName:@"icon_success"];
        }
        [self.logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoIV.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
    }];
}

- (void)showEnText {
    UIWindow* keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self];
    CGFloat hight=[UIScreen mainScreen].bounds.size.height/5.0f*2;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(keyWindow.mas_centerX);
        make.top.equalTo(keyWindow.mas_top).offset(hight);
        make.left.greaterThanOrEqualTo(@15);
        make.right.lessThanOrEqualTo(@-15);
    }];
    self.textLabel.numberOfLines = 2;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.right.top.bottom.equalTo(self);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.center.equalTo(self.contentView);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showWithEnText:(NSString *)text {
    //    if (text.length > 16) {
    //        text = [text substringToIndex:16];
    //    }
    ToastView* toast = [[ToastView alloc] initWithText:text];
    [toast showEnText];
}

+ (void)showWithText:(NSString *)text {
    if (text.length > 16) {
        text = [text substringToIndex:16];
    }
    ToastView* toast = [[ToastView alloc] initWithText:text];
    [toast show];
}

+ (void)showInfoWithText:(NSString *)text {
    if (text.length > 16) {
        text = [text substringToIndex:16];
    }
    ToastView* toast = [[ToastView alloc] initWithText:text];
    toast.toastType = WHToastType_info;
    [toast show];
}

+ (void)showSuccessWithText:(NSString *)text {
    if (text.length > 16) {
        text = [text substringToIndex:16];
    }
    ToastView* toast = [[ToastView alloc] initWithText:text];
    toast.toastType = WHToastType_success;
    [toast show];
}
@end
