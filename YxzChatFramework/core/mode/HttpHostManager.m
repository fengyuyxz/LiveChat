//
//  HttpHostManager.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/12.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "HttpHostManager.h"

@implementation HttpHostManager
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static HttpHostManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[HttpHostManager alloc]init];
    });
    return manager;
}
@end
