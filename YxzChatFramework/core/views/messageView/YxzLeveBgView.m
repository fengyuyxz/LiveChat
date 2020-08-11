//
//  YxzLeveBgView.m
//  YXZChatFramework
//
//  Created by 颜学宙 on 2020/7/22.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzLeveBgView.h"
#import "YXZConstant.h"
@interface YxzLeveBgView()
@property (nonatomic, strong) UIImageView *leveImage;
//@property (nonatomic, strong) UILabel *leveLabel;
@end


@implementation YxzLeveBgView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.leveImage];
//        [self addSubview:self.leveLabel];
        
        self.leveImage.frame = CGRectMake(2, 2, 10, 10);
//        self.leveLabel.frame = CGRectMake(12, 0, 16, 14);
    }
    return self;
}

-(void)layoutSubviews{
    self.leveImage.frame=CGRectMake(CGRectGetWidth(self.bounds)/2.0f-5, CGRectGetHeight(self.bounds)/2.0f-5, 10, 10);
}
- (void)setLevel:(NSInteger)level {
    _level = level;
    UIColor *color;
    NSString *imageName;
    self.image = nil;
//    self.leveLabel.font = [UIFont boldSystemFontOfSize:10];
    
     if (level > 0 && level <= 3) {
        color = RGBA_OF(0x8D28F1);
        imageName = @"vip";
    }else {
        color = [UIColor clearColor];
//        imageName = @"icon_rank_64_99";
//        self.image = [UIImage imageNamed:@"icon_rank_bg_64"];
        if ([NSString stringWithFormat:@"%ld", level].length >= 3) {
//            self.leveLabel.font = [UIFont boldSystemFontOfSize:7.8];
        }
    }
    
    self.backgroundColor = [UIColor whiteColor];
    // 渐变色
//    [self.leveBgImage.layer addSublayer:[YWUtils setGradualChangingColor:self.leveBgImage fromColor:MLHexColor(@"8E45EC") toColor:MLHexColor(@"FD085E")]];//color;
    
    self.leveImage.image = YxzSuperPlayerImage(imageName);
    UIView *bview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 14)];
    bview.backgroundColor=[UIColor clearColor];
    UIImage *bImg=[self convertCreateImageWithUIView:bview];
    self.image=bImg;
    if (level <= 0) level = 0;
    
    if (self.isShadeLv) {
//        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", level] attributes:@{NSShadowAttributeName:[self getTextShadow]}];
        
//        self.leveLabel.attributedText = str1;
    } else {
//        self.leveLabel.text = [NSString stringWithFormat:@"%ld", level];
    }
}

// 文字阴影效果
- (NSShadow *)getTextShadow {
    NSShadow *shadow = [[NSShadow alloc] init];
    //shadow.shadowBlurRadius = 1;
    shadow.shadowOffset = CGSizeMake(0, 0.5);
    shadow.shadowColor = RGBAOF(0x000000, 0.5);
    
    return shadow;
}
/*
- (UILabel *)leveLabel {
    if (!_leveLabel) {
        _leveLabel = [UILabel new];
        _leveLabel.textColor = RGBA_OF(0xffffff);
        _leveLabel.font = [UIFont boldSystemFontOfSize:10];
        _leveLabel.textAlignment = NSTextAlignmentCenter;
//        _leveLabel.shadowOffset = CGSizeMake(0, 0.5);
//        _leveLabel.shadowColor = RGBAOF(0x000000, 0.5);
    }
    return _leveLabel;
}*/
- (UIImage *)convertCreateImageWithUIView:(UIView *)view {
    
    //UIGraphicsBeginImageContext(view.bounds.size);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImageView *)leveImage {
    if (!_leveImage) {
        _leveImage = [UIImageView new];
    }
    return _leveImage;
}

@end
