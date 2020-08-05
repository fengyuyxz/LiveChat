//
//  YxzPopView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/31.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YxzPopView : UIView
-(void)show:(UIView *)contentView superView:(UIView *)supView;
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
