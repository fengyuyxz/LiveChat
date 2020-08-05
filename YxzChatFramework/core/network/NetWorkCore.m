//
//  NetWorkCore.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/3.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "NetWorkCore.h"
#import <pthread/pthread.h>
@interface NetWorkCore()
{
    pthread_mutex_t _mutex; // 互斥锁
}
@property (nonatomic,strong) AFHTTPSessionManager *jsonRequestOperationManager;
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@end
@implementation NetWorkCore
-(NSNumber *)getRequestForURLStr:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header completion:(ReqCompletion)block{
    __weak typeof(self) weakSelf = self;
  NSURLSessionDataTask *sessionTask = [self.jsonRequestOperationManager GET:url parameters:param headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        if (block) {
            block(nil,responseObject);
        }
           #if defined(DEBUG)||defined(_DEBUG)
               NSLog(@"success url = %@",task.currentRequest.URL);
           #endif
           [strongSelf removeTask:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        
         if (block) {
             block(error,nil);
         }
        #if defined(DEBUG)||defined(_DEBUG)
         NSLog(@"error url = %@",task.currentRequest.URL);
        #endif
         [strongSelf removeTask:task];
    }];
 
    NSNumber *requestId = @([sessionTask taskIdentifier]);


    [self insertRequetIdToDic:requestId withSessinTast:sessionTask];
    
    [sessionTask resume];
    return requestId;
}
-(NSNumber *)postRequestForURLStr:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header completion:(ReqCompletion)block{
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *sessionTask =[self.jsonRequestOperationManager POST:url parameters:param headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
               if (block) {
                   block(nil,responseObject);
               }
               #if defined(DEBUG)||defined(_DEBUG)
                   NSLog(@"success url = %@",task.currentRequest.URL);
               #endif
               [strongSelf removeTask:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
               
               if (block) {
                   block(error,nil);
               }
              #if defined(DEBUG)||defined(_DEBUG)
                 NSLog(@"error url = %@",task.currentRequest.URL);
              #endif
               [strongSelf removeTask:task];
    }];
    
    NSNumber *requestId = @([sessionTask taskIdentifier]);


    [self insertRequetIdToDic:requestId withSessinTast:sessionTask];
    [sessionTask resume];
    return requestId;
}
#pragma mark - 删除保存的sessionTask
-(void)removeTask:(NSURLSessionDataTask *)task{
    NSNumber *removeRqID;
    
    if(self!=nil&&[self isKindOfClass:[NetWorkCore class]]){
        @try {
            NSMutableDictionary *dicList=[self.dispatchTable mutableCopy];
            NSArray *allKeys=[dicList allKeys];
            for (NSNumber *requestID in dicList) {
                NSURLSessionDataTask *obj=dicList[requestID];
                if ([obj isEqual:task]) {
                    removeRqID=requestID;
                    break;
                }
            }
            if (removeRqID && allKeys &&[allKeys containsObject:removeRqID]) {
                @synchronized (self.dispatchTable) {
                    [self.dispatchTable removeObjectForKey:removeRqID];
                }
            }
            
        } @catch (NSException *exception) {
            
        }
    }
    
    
}

-(void)insertRequetIdToDic:(NSNumber *)requestId withSessinTast:(NSURLSessionDataTask *)sessionTask{
    if(self!=nil&&[self isKindOfClass:[NetWorkCore class]]){
        if(requestId!=nil&&sessionTask!=nil&&![requestId isKindOfClass:[NSNull class]]&&self!=nil&&[self.dispatchTable isKindOfClass:[NSMutableDictionary class]])  {
            @synchronized (self.dispatchTable) {
                self.dispatchTable[requestId] = sessionTask;
            }
        }
    }
    
    
}
/**
 取消某个请求
 @param requestID 为发出请求的返回值
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionDataTask *sessionTask= self.dispatchTable[requestID];
    if (sessionTask) {
        [sessionTask cancel];
        [self removeTask:sessionTask];
        
    }
}
/**
 取消该对象的所有请求
 */
-(void)cancelAllRequest{
    NSArray *list=[self.dispatchTable allKeys];
    [self cancelRequestWithRequestIDList:list];
}
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList{
    
    for (NSNumber *requestID in requestIDList) {
        [self cancelRequestWithRequestID:requestID];
    }
}

#pragma mark -getter
-(NSMutableDictionary *)dispatchTable{
    if (!_dispatchTable) {
        _dispatchTable=[[NSMutableDictionary alloc]init];
    }
    return _dispatchTable;
}
-(AFHTTPSessionManager *)jsonRequestOperationManager{
    if (!_jsonRequestOperationManager) {
        _jsonRequestOperationManager=[AFHTTPSessionManager manager];
        
        [_jsonRequestOperationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _jsonRequestOperationManager.requestSerializer.timeoutInterval =15;
        [_jsonRequestOperationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _jsonRequestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _jsonRequestOperationManager.responseSerializer.acceptableContentTypes = [_jsonRequestOperationManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:[NSArray arrayWithObjects:@"multipart/form-data",@"text/html",@"text/plain",@"text/javascript",@"application/json",@"image/jpeg",@"image/png",@"video/mp4", nil]];
        
    }
    return _jsonRequestOperationManager;
}
-(void)setTimeOut:(NSTimeInterval)timeOut{
    [self.jsonRequestOperationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.jsonRequestOperationManager.requestSerializer.timeoutInterval =timeOut;
    [self.jsonRequestOperationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}
@end
