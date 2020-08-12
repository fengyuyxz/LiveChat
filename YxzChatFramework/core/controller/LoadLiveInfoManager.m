//
//  LoadLiveInfoManager.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/5.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "LoadLiveInfoManager.h"
#import "NetWorkRequestManager.h"
#import "HttpHostManager.h"
#import "NSString+Empty.h"
#import <MJExtension/MJExtension.h>
#import "ToastView.h"
@interface LoadLiveInfoManager()
@property(nonatomic,strong)NetWorkRequestManager *request;
@end
@implementation LoadLiveInfoManager
-(void)loadLiveInfo:(NSString *)userToken liveId:(NSString *)liveId completion:(loadLiveInfoCompletion)block{
    //
//    NSString *url=@"http://www.pts.ifanteam.com/api/live/detail";
    NSString *url=[NSString stringWithFormat:@"%@/api/live/detail",[HttpHostManager shareInstance].host];
    
    NSMutableDictionary *param=[@{} mutableCopy];
    if (![NSString isEmpty:liveId]) {
        [param setValue:liveId forKey:@"id"];
    }
    
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
        [ToastView showWithEnText:@"获取直播信息错误请稍后重试"];
        if (block) {
            block(NO,nil);
        }
    }];
}
-(void)vote:(NSString *)liveId voteId:(int)voteId userToken:(NSString *)userToken completion:(void(^)(BOOL isSUC,VoteNetResult *result))block{
//    NSString *url=@"http://www.pts.ifanteam.com/api/live/sendVote";
    NSString *url=[NSString stringWithFormat:@"%@/api/live/sendVote",[HttpHostManager shareInstance].host];
       NSMutableDictionary *param=[@{} mutableCopy];
       if (![NSString isEmpty:liveId]) {
           [param setValue:liveId forKey:@"live_id"];
       }
    
        [param setValue:@(voteId) forKey:@"voteitemid"];
    
       
       if (![NSString isEmpty:userToken]) {
           [param setValue:userToken forKey:@"token"];
       }
       [self.request post:url param:param header:nil success:^(NSDictionary *originalResponseResult) {
           VoteNetResult * reuslt= [[VoteNetResult class] mj_objectWithKeyValues:originalResponseResult];
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
