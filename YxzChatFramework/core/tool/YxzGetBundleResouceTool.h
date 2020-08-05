//
//  YxzGetBundleResouceTool.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YxzFaceItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface YxzGetBundleResouceTool : NSObject
+(instancetype)shareInstance;
-(UIImage *)getImageWithImageName:(NSString *)imageName;
-(UIImage *)getFaceWithImageName:(NSString *)imageName;
+(NSArray<YxzFaceItem *> *)getBundlerFace;
@end

NS_ASSUME_NONNULL_END
