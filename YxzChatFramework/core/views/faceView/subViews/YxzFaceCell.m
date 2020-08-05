//
//  YxzFaceCell.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzFaceCell.h"
#import <Masonry/Masonry.h>
#import "YxzGetBundleResouceTool.h"
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
    _faceImgView.image=[[YxzGetBundleResouceTool shareInstance] getFaceWithImageName:[[_item.face_name stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""]];
}
@end
