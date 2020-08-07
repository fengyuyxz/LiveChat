//
//  WHFaceItem.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YxzFaceItem : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,assign)BOOL is_vip;
@property(nonatomic,assign)int value_type;
@property(nonatomic,assign)int value;
@property(nonatomic,assign)int type;
@end

NS_ASSUME_NONNULL_END
