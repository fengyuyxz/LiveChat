//
//  VoteView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/2.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "VoteView.h"
#import "YXZConstant.h"
#import "ToastView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Empty.h"
#import "LoadLiveInfoManager.h"
@interface VoteView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *contentTitleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIButton *closeBut;
@property(nonatomic,strong)UIImageView *tipsImageView;
@property(nonatomic,strong)LoadLiveInfoManager *request;

@end
@implementation VoteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self layoutConstraints];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
        [self layoutConstraints];
    }
    return self;
}
-(void)setupView{
    self.backgroundColor=[UIColor whiteColor];
    self.layer.cornerRadius=4;
    [self addSubview:self.title];
    [self addSubview:self.contentTitleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.closeBut];
    [self addSubview:self.tipsImageView];
}
-(void)layoutConstraints{
    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.left.top.equalTo(self).offset(15);
    }];
    [self.closeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.title.mas_bottom).offset(20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTitleLabel.mas_right).offset(15);
        make.top.equalTo(self.title.mas_bottom).offset(20);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
    }];
}
-(void)setDataSouce:(NSMutableArray<VoteItemModel *> *)dataSouce{
    _dataSouce=dataSouce;
    VoteItemModel *mode=[dataSouce firstObject];
    CGFloat hight=160;
    if ([NSString isEmpty:mode.pic]) {
        hight=80;
    }
    if (_dataSouce.count>2) {
        hight*=2;
    }
    hight+=7+123;
    CGRect frect=self.frame;
    frect.size.height=hight;
    self.frame=frect;
    [self.collectionView reloadData];
}
-(void)closeButPressed{
    if (self.block) {
        dispatch_async(dispatch_get_main_queue(), ^{
             self.block();
        });
    }
}
#pragma mark - collection layout ====================
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    VoteItemModel *model=[self.dataSouce firstObject];
    CGFloat hight=160;
    if ([NSString isEmpty:model.pic]) {
        hight=80;
    }
    return CGSizeMake(CGRectGetWidth(self.bounds)/2.0f, hight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - collection dataSouce ====================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSouce) {
        return self.dataSouce.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VoteViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"VoteViewCell" forIndexPath:indexPath];
    VoteItemModel *item=self.dataSouce[indexPath.row];
    cell.item=item;
    cell.delegate=self;
    return cell;
}
#pragma makr - 投票回调===
-(void)vote:(VoteItemModel *)voteMode{
    [self.request vote:self.liveId voteId:voteMode.voteId userToken:self.userToken completion:^(BOOL isSUC, VoteNetResult * _Nonnull result) {
        if (isSUC) {
            [ToastView showWithText:@"投票成功"];
            self.voteResultModel=result.data;
            
        }else if(result){
            [ToastView showWithText:[NSString stringWithFormat:@"%@",![NSString isEmpty:result.msg]?result.msg:@"投票失败"]];
        }
    }];
}
#pragma mark - getter =====
-(void)setVoteResultModel:(VoteItemModelResult *)voteResultModel{
    _voteResultModel=voteResultModel;
    self.dataSouce=[_voteResultModel.items mutableCopy];
    self.contentLabel.text=_voteResultModel.title;
    [self.collectionView reloadData];
}
-(UILabel *)title{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.font=[UIFont systemFontOfSize:24];
        _title.text=@"互动投票";
        _title.textColor=[UIColor blackColor];
    }
    return _title;
}
-(UILabel *)contentTitleLabel{
    if (!_contentTitleLabel) {
        _contentTitleLabel=[[UILabel alloc]init];
        _contentTitleLabel.font=[UIFont systemFontOfSize:15];
        _contentTitleLabel.text=@"主题";
        _contentTitleLabel.textColor=RGBA_OF(0xc1c0c9);
    }
    return _contentTitleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]init];
        _contentLabel.font=[UIFont systemFontOfSize:15];
        _contentLabel.text=@"";
        _contentLabel.numberOfLines=2;
        _contentLabel.textAlignment=NSTextAlignmentLeft;
        _contentLabel.textColor=[UIColor blackColor];
    }
    return _contentLabel;
}
-(UIImageView *)tipsImageView{
    if (!_tipsImageView) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=YxzSuperPlayerImage(@"jinggao");
    }
    return _tipsImageView;
}
-(UIButton *)closeBut{
    if (!_closeBut) {
        _closeBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBut setImage:YxzSuperPlayerImage(@"guanbi") forState:UIControlStateNormal];
        [_closeBut addTarget:self action:@selector(closeButPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBut;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[VoteViewCell class] forCellWithReuseIdentifier:@"VoteViewCell"];
    
    }
    return _collectionView;
}
-(LoadLiveInfoManager *)request{
    if (!_request) {
        _request=[[LoadLiveInfoManager alloc]init];
    }
    return _request;
}
@end
@interface PopVoteView()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *animationContainerView;
@property(nonatomic,strong)UIView *supView;
@end
@implementation PopVoteView

-(void)show:(UIView *)contentView superView:(UIView *)supView{
    _contentView=contentView;
    [self.animationContainerView removeFromSuperview];
    self.animationContainerView.frame=CGRectMake(CGRectGetWidth(supView.bounds)/2.0f-CGRectGetWidth(_contentView.bounds)/2.0f, CGRectGetHeight(supView.bounds)/2.0f-CGRectGetHeight(_contentView.bounds)/2.0f, CGRectGetWidth(_contentView.bounds), CGRectGetHeight(_contentView.bounds));
    [self.animationContainerView addSubview:_contentView];
    
    
    
    [self addSubview:self.animationContainerView];
    [self removeFromSuperview];
    [supView addSubview:self];
    _supView=supView;
    self.alpha=0;
    self.animationContainerView.transform=CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            self.animationContainerView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}
-(void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.animationContainerView.transform=CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.animationContainerView removeFromSuperview];
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            self.contentView=nil;
            [self removeFromSuperview];
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



@interface VoteViewCell()
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)ProcessButton *voteBut;
@property(nonatomic,strong)UIView *voteView;
@property(nonatomic,strong)UILabel *label;
@end
@implementation VoteViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self layoutConstraints];
    }
    return self;
}
-(void)setItem:(VoteItemModel *)item{
    _item=item;
    
    
    if ([NSString isEmpty:_item.pic]) {
        [self.topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top);
            make.height.width.mas_equalTo(0);
        }];
    }else{
        [self.topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.centerX.equalTo(self.mas_centerX);
                   make.top.equalTo(self.mas_top);
                   make.height.width.mas_equalTo(80);
               }];
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_item.pic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    self.label.text=_item.title;
    [self.voteBut setTitle:_item.title forState:UIControlStateNormal];
    self.voteBut.process=_item.percent/100.0f;
    
}
-(void)setupView{
    [self addSubview:self.topImageView];
    [self addSubview:self.voteView];
    [self.voteView addSubview:self.label];
    [self.voteView addSubview:self.voteBut];
}
-(void)layoutConstraints{
    [self.label setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisVertical];
    [self.label setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisVertical];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voteView.mas_left).offset(40);
        make.right.equalTo(self.voteView.mas_right).offset(-40);
        make.top.equalTo(self.voteView.mas_top).offset(3);
        make.bottom.equalTo(self.voteView.mas_bottom).offset(-3);
    }];
    [self.voteBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.voteView);
    }];
    [self.voteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
//        make.bottom.greaterThanOrEqualTo(self.mas_bottom).offset(-20);
        make.top.equalTo(self.topImageView.mas_bottom).offset(25);
    }];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
}
-(void)voteButPressed{
    if ([self.delegate respondsToSelector:@selector(vote:)]) {
        [self.delegate vote:self.item];
    }
}
-(UIView *)voteView{
    if (!_voteView) {
        _voteView=[[UIView alloc]init];
        _voteView.backgroundColor=[UIColor clearColor];
        
        _voteView.clipsToBounds=YES;
        _voteView.layer.cornerRadius=12.5;
    }
    return _voteView;
}
-(UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc]init];
        _topImageView.layer.cornerRadius=40;
        _topImageView.clipsToBounds=YES;
    }
    return _topImageView;
}
-(ProcessButton *)voteBut{
    if (!_voteBut) {
        _voteBut=[ProcessButton buttonWithType:UIButtonTypeCustom];
        _voteBut.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [_voteBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_voteBut addTarget:self action:@selector(voteButPressed) forControlEvents:UIControlEventTouchUpInside];
        _voteBut.layer.borderColor=RGBA_OF(0xffcbdd).CGColor;
        _voteBut.clipsToBounds=YES;
               _voteView.layer.borderWidth=1;
               _voteView.layer.cornerRadius=12.5;
    }
    return _voteBut;
}
-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]init];
        _label.font=[UIFont boldSystemFontOfSize:14];
        _label.hidden=YES;
        _label.textColor=[UIColor blackColor];
    }
    return _label;
}
@end


