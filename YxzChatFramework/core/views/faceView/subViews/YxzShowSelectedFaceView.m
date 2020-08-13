//
//  YxzShowSelectedFaceView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/25.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzShowSelectedFaceView.h"

#import "YXZConstant.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface YxzShowSelectedFaceView()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *closeButton;
@end
@implementation YxzShowSelectedFaceView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
-(void)setupSubViews{
    self.backgroundColor=RGBAOF(0x000000,0.56);
    _imageView=[[UIImageView alloc]init];
    [self addSubview:_imageView];
    [self addSubview:self.closeButton];
    [self layoutSubViewConstraint];
}
-(void)layoutSubViewConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.imageView.mas_height).multipliedBy(1);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.height.equalTo(@(30));
    }];
}
-(void)setImageURLStr:(NSString *)imageURLStr{
    _imageURLStr=imageURLStr;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageURLStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
-(void)closeButPressed{
    if ([self.delegate respondsToSelector:@selector(delSelectedFaceImg)]) {
        [self.delegate delSelectedFaceImg];
    }
}
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:YxzSuperPlayerImage(@"icon_del") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;;
}
@end
