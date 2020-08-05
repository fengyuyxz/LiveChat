//
//  VoteView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/2.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface VoteItemModel : NSObject
@property(nonatomic,copy)NSString *imgeUrlStr;
@property(nonatomic,copy)NSString *title;

@end

@interface VoteViewCell : UICollectionViewCell
@property(nonatomic,strong)VoteItemModel *item;
@end


@interface VoteView : UIView
typedef void(^closeCompelation)(void);
@property(nonatomic,copy)closeCompelation block;
@property(nonatomic,strong)NSMutableArray<VoteItemModel *> *dataSouce;
@end


@interface PopVoteView : UIView
-(void)show:(UIView *)contentView superView:(UIView *)supView;
-(void)dismiss;
@end
