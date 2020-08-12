//
//  HttpHostManager.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/12.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpHostManager : NSObject
@property(nonatomic,strong)NSString *host;
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
