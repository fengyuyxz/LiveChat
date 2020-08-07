//
//  YxzFaceCell.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzFaceCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface YxzFaceCell()
@property(nonatomic,strong)UIImageView *faceImgView;
@end
@implementation YxzFaceCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTabCell];
    }
    return self;
}
-(void)setupTabCell{
    _faceImgView=[[UIImageView alloc]init];
    [self addSubview:_faceImgView];
    [_faceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@(40));
    }];
}
-(void)setItem:(YxzFaceItem *)item{
    _item=item;
    NSURL *imageUrl=[NSURL URLWithString:item.icon];
    [self.faceImgView sd_setImageWithURL:imageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
@end
