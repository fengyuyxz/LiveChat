//
//  LoadLiveInfoManager.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/5.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "LoadLiveInfoManager.h"
#import "NetWorkRequestManager.h"
#import "NSString+Empty.h"
#import <MJExtension/MJExtension.h>
@interface LoadLiveInfoManager()
@property(nonatomic,strong)NetWorkRequestManager *request;
@end
@implementation LoadLiveInfoManager
-(void)loadLiveInfo:(NSString *)userToken completion:(loadLiveInfoCompletion)block{
    //
    NSString *url=@"http://www.pts.ifanteam.com/api/live/detail";
    NSMutableDictionary *param=[@{} mutableCopy];
    [param setValue:@"93" forKey:@"id"];
    if (![NSString isEmpty:userToken]) {
        [param setValue:userToken forKey:@"token"];
    }
    [self.request post:url param:param header:nil success:^(NSDictionary *originalResponseResult) {
        LiveRoomInfoModel * reuslt= [[LiveRoomInfoModel class] mj_objectWithKeyValues:originalResponseResult];
        if (reuslt.code==1) {
            if (block) {
                block(YES,reuslt);
            }
        }else{
            if (block) {
                block(NO,reuslt);
            }
        }
    } fail:^(NSError *error) {
        if (block) {
            block(NO,nil);
        }
    }];
}
-(NetWorkRequestManager *)request{
    if (!_request) {
        _request=[[NetWorkRequestManager alloc]init];
    }
    return _request;
}
@end