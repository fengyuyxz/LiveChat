//
//  NetWorkRequestManager.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/4.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "NetWorkRequestManager.h"
#import "NetWorkCore.h"
#define backMainQueen(f) dispatch_async(dispatch_get_main_queue(), ^{{f}});
@interface NetWorkRequestManager()
@property(nonatomic,strong)NetWorkCore *request;
@end
@implementation NetWorkRequestManager
-(NSNumber *)get:(NSString *)urlString param:(NSDictionary *)paramDic header:(NSDictionary *)header success:(successNotProcessCompletion)successCallback fail:(failCompletion)failCallback{
    return [self.request getRequestForURLStr:[self encodingURLString:urlString] param:paramDic header:header completion:^(NSError *error, NSDictionary *result) {
        if (!error) {
            if (successCallback) {
                
                backMainQueen(successCallback(result);)
                
            }
        }else{
            if (failCallback) {
                backMainQueen(failCallback(error);)
            }
        }
    }];
}
-(NSNumber *)post:(NSString *)urlString param:(NSDictionary *)paramDic header:(NSDictionary *)header success:(successNotProcessCompletion)successCallback fail:(failCompletion)failCallback{
    return [self.request postRequestForURLStr:[self encodingURLString:urlString] param:paramDic header:header completion:^(NSError *error, NSDictionary *result) {
        if (!error) {
            if (successCallback) {
                
                backMainQueen(successCallback(result);)
                
            }
        }else{
            if (failCallback) {
                backMainQueen(failCallback(error);)
            }
        }
    }];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    [self.request cancelRequestWithRequestID:requestID];
}
-(void)cancelAllRequest{
    [self.request cancelAllRequest];
}
-(void)setTimeOut:(NSTimeInterval)timeOut{
    [self.request setTimeOut:timeOut];
}

-(NSString *)encodingURLString:(NSString *)urlString{
    NSString *url = urlString;
    if (@available(ios 9,*)) {
        url=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
        url= [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return url;
}
-(NetWorkCore *)request{
    if (!_request) {
        _request=[[NetWorkCore alloc]init];
    }
    return _request;
}
@end
