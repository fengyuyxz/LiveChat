//
//  YxzChatController.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoomBaseInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface YxzChatController : UIViewController
typedef void(^ShareCompletion)(void);
@property(nonatomic,copy)ShareCompletion shareBlock;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *liveId;
@end

NS_ASSUME_NONNULL_END
