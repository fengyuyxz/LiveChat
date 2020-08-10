//
//  BackgroundAnimationMessage.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/10.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackgroundAnimationMessage : RCMessageContent
@property(nonatomic,copy)NSString *animation;
@end

NS_ASSUME_NONNULL_END
