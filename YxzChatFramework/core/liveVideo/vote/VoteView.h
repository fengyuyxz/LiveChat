//
//  VoteView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/2.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VoteItemModelResult.h"



@interface VoteViewCell : UICollectionViewCell
@property(nonatomic,strong)VoteItemModel *item;
@end


@interface VoteView : UIView
typedef void(^closeCompelation)(void);
@property(nonatomic,copy)closeCompelation block;
@property(nonatomic,strong)VoteItemModelResult *voteResultModel;
@property(nonatomic,strong)NSMutableArray<VoteItemModel *> *dataSouce;
@end


@interface PopVoteView : UIView
-(void)show:(UIView *)contentView superView:(UIView *)supView;
-(void)dismiss;
@end
