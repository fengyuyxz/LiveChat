//
//  PraiseMessagModel.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/10.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface PraiseMessagModel : RCMessageContent
@property(nonatomic,assign)int btn_type;//点赞but 类型区分动画类型
@property(nonatomic,assign)int times;//一秒内用户连续点击了多少次点赞按钮
@end

NS_ASSUME_NONNULL_END
