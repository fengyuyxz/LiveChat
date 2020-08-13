//
//  YxzFaceContainerView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzFaceContainerView.h"


#import <Masonry/Masonry.h>
#import "YXZConstant.h"

#import "YxzFaceCell.h"
#define  BOTTOM_FACE_TOOL_BAR_H 40
@interface YxzFaceContainerView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIView *bottomFaceTool;
@property(nonatomic,strong)UIButton *addMoreFaceBut;
@property(nonatomic,strong)UICollectionView *collectionView;




@end
@implementation YxzFaceContainerView

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
- (CGFloat)faceContainerH{
    return 150+BOTTOM_FACE_TOOL_BAR_H;
}
-(void)setFaceList:(NSArray<YxzFaceItem *> *)faceList{
    [self.faceDataSouce addObjectsFromArray:faceList];
    [self.collectionView reloadData];
}
-(void)showFace{
    
    [self.collectionView reloadData];
}
-(void)setupSubViews{
    self.userInteractionEnabled=YES;
    [self addSubview:self.bottomFaceTool];
    [self addSubview:self.collectionView];
    UIView *line=[self lineView];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomFaceTool.mas_top);
        make.height.equalTo(@(0.5));
    }];
    [self.bottomFaceTool addSubview:self.addMoreFaceBut];
    [self layoutSubViewConstraint];
    
    UIView *line2=[self lineView];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(0.5));
    }];
    
    
}
-(UIView *)lineView{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=RGBAOF(0X9A9A9D,0.1);
    return view;
}
-(void)layoutSubViewConstraint{
    [self.bottomFaceTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(BOTTOM_FACE_TOOL_BAR_H));
        make.left.right.bottom.equalTo(self);
    }];
    [self.addMoreFaceBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomFaceTool.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.bottomFaceTool.mas_top);
    }];
}
#pragma mark - collection layout ====================
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat w=device_sceen_width/4.0f;
    
    return CGSizeMake(w, device_sceen_width/5.0f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - collection dataSouce ====================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.faceDataSouce) {
        return self.faceDataSouce.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YxzFaceCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"YxzFaceCell" forIndexPath:indexPath];
    YxzFaceItem *item=self.faceDataSouce[indexPath.row];
    cell.item=item;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YxzFaceItem *item=self.faceDataSouce[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectedFace:)]) {
        
        [self.delegate didSelectedFace:item.icon];
    }
}
-(UIView *)bottomFaceTool{
    if (!_bottomFaceTool) {
        _bottomFaceTool=[[UIView alloc]init];
        _bottomFaceTool.backgroundColor=[UIColor whiteColor];
    }
    return _bottomFaceTool;
}
-(UIButton *)addMoreFaceBut{
    if (!_addMoreFaceBut) {
        _addMoreFaceBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addMoreFaceBut setBackgroundImage:YxzSuperPlayerImage(@"moreTool") forState:UIControlStateNormal];
    }
    return _addMoreFaceBut;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[YxzFaceCell class] forCellWithReuseIdentifier:@"YxzFaceCell"];
    
    }
    return _collectionView;
}
-(NSMutableArray<YxzFaceItem *> *)faceDataSouce{
    if (!_faceDataSouce) {
        
        _faceDataSouce=[NSMutableArray array];
    }
    return _faceDataSouce;
}
@end
