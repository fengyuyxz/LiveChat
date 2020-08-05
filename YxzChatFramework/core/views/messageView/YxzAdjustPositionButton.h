//
//  YxzAdjustPositionButton.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, AdjustPositionButtonStyle) {
    AdjustPositionButtonStyleLeftImageRightTitle,
    AdjustPositionButtonStyleLeftTitleRightImage,
    AdjustPositionButtonStyleeTopImageBottomTitle,
    AdjustPositionButtonStyleTopTitleBottomImage
};
NS_ASSUME_NONNULL_BEGIN

@interface YxzAdjustPositionButton : UIButton
@property(nonatomic,assign)AdjustPositionButtonStyle layoutStyle;
@property(nonatomic,assign)CGSize imageSize;
@property(nonatomic,assign)CGFloat midSpacing;
@end

NS_ASSUME_NONNULL_END
