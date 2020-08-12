//
//  YxzLeveBgView.m
//  YXZChatFramework
//
//  Created by 颜学宙 on 2020/7/22.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzLeveBgView.h"

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

    self.backgroundColor = [UIColor whiteColor];

    NSArray<UIColor *> *colors=@[RGBA_OF(0xFFC700),RGBA_OF(0xFFBBD3)];
    
    self.leveImage.image = YxzSuperPlayerImage(@"vip");
    UIView *bview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 14)];
    bview.backgroundColor=colors[level];
    UIImage *bImg=[self convertCreateImageWithUIView:bview];
    self.image=bImg;
    if (level <= 0) level = 0;
    

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
