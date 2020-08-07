//
//  RongCloudManager.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/7.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "RongCloudManager.h"
#import <MJExtension/MJExtension.h>
#import "NSString+Empty.h"
#import <RongIMLib/RongIMLib.h>
#import "NetWorkRequestManager.h"
#define RONG_CLOUD_APP_KEY @"k51hidwqkvjyb"
@interface RongCloudManager()<RCIMClientReceiveMessageDelegate>
@property(nonatomic,assign)BOOL isConnected;
@property(nonatomic,strong)NetWorkRequestManager *request;
@property(nonatomic,assign)NSInteger connectTimes;
@end
@implementation RongCloudManager
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static RongCloudManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[RongCloudManager alloc]init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
        _connectTimes=0;
    }
    return self;
}
+(void)loadRongCloudSdk{
    [[RCIMClient sharedRCIMClient] initWithAppKey:RONG_CLOUD_APP_KEY];
}
-(void)connectRongCloudService:(NSString *)token userToken:(NSString *)userToken completion:(void(^)(BOOL isConnect,NSString *userId))block{
    [[RCIMClient sharedRCIMClient]connectWithToken:token success:^(NSString *userId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(block){
                      block(YES,userId);
                  }
        });
      
    } error:^(RCConnectErrorCode status) {
        if (status==RC_CONN_TOKEN_INCORRECT) {//token无效
            if(block){
                      block(NO,nil);
                  }
        }else if(RC_CONNECTION_EXIST==status){
            dispatch_async(dispatch_get_main_queue(), ^{
                              if(block){
                                  block(YES,nil);
                              }
                          });
        }
       
      
    } tokenIncorrect:^{
        // token无效重新请求token再次 发起连接 不过避免出现无限循环 应该 手动添加获取次数限制
       
        dispatch_async(dispatch_get_main_queue(), ^{
                   if(block){
                                     block(NO,nil);
                                 }
               });
        [self ageinConnectUserToken:userToken completion:block];
    }];
}
-(void)ageinConnectUserToken:(NSString *)userToken completion:(void(^)(BOOL isConnect,NSString *userId))block{
    if (_connectTimes>=3) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self getRongCloudTokenWithUserToken:userToken completion:^(BOOL isSUC, ChatRoomUserInfoAndTokenModel *model) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        if (isSUC) {
            strongSelf.connectTimes++;
            [weakSelf connectRongCloudService:model.imtoken userToken:userToken completion:block];
        }
        
        
    }];
}
-(void)getRongCloudTokenWithUserToken:(NSString *)userToken completion:(void(^)(BOOL isSUC,ChatRoomUserInfoAndTokenModel *model))block{
    NSString *url=@"http://www.pts.ifanteam.com/api/userinfo/imlogin";
       NSMutableDictionary *param=[@{} mutableCopy];
       [param setValue:@"93" forKey:@"live_id"];
       if (![NSString isEmpty:userToken]) {
           [param setValue:userToken forKey:@"token"];
       }
       [self.request post:url param:param header:nil success:^(NSDictionary *originalResponseResult) {
           RongCloudTokenResult *result= [[RongCloudTokenResult class] mj_objectWithKeyValues:originalResponseResult];
           if (result.code==1) {
               if (block) {
                   block(YES,result.data);
               }
           }else{
               if (block) {
                   block(NO,nil);
               }
           }
       } fail:^(NSError *error) {
          if (block) {
              block(NO,nil);
          }
       }];
}

-(void)setUserId:(NSString *)userId userName:(NSString *)userName{
    RCUserInfo *userInfo=[[RCUserInfo alloc]initWithUserId:userId name:userName portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo=userInfo;
}
-(void)joinChatRoom:(NSString *)roomId completion:(void(^)(BOOL joinSuc,RCErrorCode code))block{
    /*
    [[RCIMClient sharedRCIMClient]  joinExistChatRoom:roomId messageCount:-1 success:^{
        if (block) {
            block(YES,0);
        }
    } error:^(RCErrorCode status) {
        if (block) {
            block(YES,status);
        }
    }];
    */
    [[RCIMClient sharedRCIMClient] joinChatRoom:roomId messageCount:-1 success:^{

        if (block) {
            block(YES,0);
        }
    } error:^(RCErrorCode status) {
        if (block) {
            block(YES,status);
        }
    }];
    
}
-(void)quitRoom:(NSString *)roomId completion:(void(^)(BOOL joinSuc,RCErrorCode code))block{
    
    [[RCIMClient sharedRCIMClient] quitChatRoom:roomId success:^{
        if (block) {
            block(YES,0);
        }
    } error:^(RCErrorCode status) {
        if (block) {
            block(YES,status);
        }
    }];
}
-(void)disConnect{
    [[RCIMClient sharedRCIMClient]disconnect:NO];
}
- (void)onReceived:(RCMessage *)message
      left:(int)nLeft
    object:(id)object
   offline:(BOOL)offline
        hasPackage:(BOOL)hasPackage{
    NSLog(@"");
}
-(NetWorkRequestManager *)request{
    if (!_request) {
        _request=[[NetWorkRequestManager alloc]init];
    }
    return _request;
}
@end
