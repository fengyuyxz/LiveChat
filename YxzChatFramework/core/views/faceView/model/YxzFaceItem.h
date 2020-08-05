//
//  WHFaceItem.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YxzFaceItem : NSObject
@property(nonatomic,copy)NSString *faceUrl;
@property(nonatomic,copy)NSString *faceName;
@property(nonatomic,assign)BOOL isNativeFace;

// 测试本地 加载face
@property(nonatomic,copy)NSString *face_id;
@property(nonatomic,copy)NSString *face_name;
@property(nonatomic,copy)NSString *face_zh_name;
@property(nonatomic,assign)BOOL isGIF;

@end

NS_ASSUME_NONNULL_END
