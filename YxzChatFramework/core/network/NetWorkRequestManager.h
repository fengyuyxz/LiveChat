//
//  NetWorkRequestManager.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/4.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NetWorkRequestManager : NSObject
/**
 请求成功回调block
 @param originalResponseResult 接口返回原始未处理过的数据
 */
typedef void(^successNotProcessCompletion)(NSDictionary *originalResponseResult);
/**
 请求异常回调block
 @param error 网络错误或接口服务异常抛出的
 */
typedef void(^failCompletion)(NSError *error);


/// get 请求
/// @param urlString 请求地址
/// @param paramDic 请求入参
/// @param header 请求额外头部参数
/// @param successCallback 成功回调
/// @param failCallback 失败回调
-(NSNumber *)get:(NSString *)urlString param:(NSDictionary *)paramDic header:(NSDictionary *)header success:(successNotProcessCompletion)successCallback fail:(failCompletion)failCallback;



/// post 请求
/// @param urlString 请求地址
/// @param paramDic 请求入参
/// @param header 请求额外头部参数
/// @param successCallback 成功回调
/// @param failCallback 失败回调
-(NSNumber *)post:(NSString *)urlString param:(NSDictionary *)paramDic header:(NSDictionary *)header success:(successNotProcessCompletion)successCallback fail:(failCompletion)failCallback;
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


