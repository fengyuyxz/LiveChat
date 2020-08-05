//
//  YxzShowSelectedFaceView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/25.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShowSelectedFaceDelegate <NSObject>

-(void)delSelectedFaceImg;

@end
@interface YxzShowSelectedFaceView : UIView
@property(nonatomic,weak)id<ShowSelectedFaceDelegate> delegate;
@property(nonatomic,copy)NSString *imageURLStr;
@end

NS_ASSUME_NONNULL_END

