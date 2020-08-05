//
//  NetWorkCore.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/3.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

@interface NetWorkCore : NSObject
typedef void(^ReqCompletion)(NSError *error,NSDictionary *result);
/**
  get 请求 返回tasksession id 用于取消指定某个请求如本请求取消等
  @param url 访问地址url
  @param param  请求参数
  @param header 头部额外信息
  @param block 请求回调
 */
-(NSNumber *)getRequestForURLStr:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header completion:(ReqCompletion)block;
/**
 post 请求 返回tasksession id 用于取消指定某个请求如本请求取消等
 @param urlString 访问地址url
 @param paramDic 请求参数
 @param header 头部额外信息
 @param block 请求回调
 */
-(NSNumber *)postRequestForURLStr:(NSString *)urlString param:(NSDictionary *)paramDic header:(NSDictionary *)header completion:(ReqCompletion)block;

/**
 取消某个请求
 @param requestID 为发出请求的返回值
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
/**
 取消该对象的所有请求
 */
-(void)cancelAllRequest;
-(void)setTimeOut:(NSTimeInterval)timeOut;
@end


