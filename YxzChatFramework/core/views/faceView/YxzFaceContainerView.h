//
//  YxzFaceContainerView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YxzFaceItem.h"
NS_ASSUME_NONNULL_BEGIN
@protocol YxzFaceSeletedDelegate <NSObject>

-(void)didSelectedFace:(NSString *)imgurl;

@end
@interface YxzFaceContainerView : UIView
@property(nonatomic,strong)NSMutableArray<YxzFaceItem *> *faceDataSouce;
@property(nonatomic,weak)id<YxzFaceSeletedDelegate> delegate;
@property(nonatomic,assign)CGFloat faceContainerH;
-(void)showFace;
@end

NS_ASSUME_NONNULL_END
