//
//  YxzGetBundleResouceTool.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzGetBundleResouceTool.h"
#import <MJExtension/MJExtension.h>
@interface YxzGetBundleResouceTool()
@property(nonatomic,strong)NSMutableDictionary<NSString *,UIImage *> *imageCahce;
@end
@implementation YxzGetBundleResouceTool
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static YxzGetBundleResouceTool *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[YxzGetBundleResouceTool alloc]init];
    });
    return manager;
}
-(UIImage *)getImageWithImageName:(NSString *)imageName{
    UIImage *image=[self.imageCahce objectForKey:imageName];
    if (!image) {
        image=[YxzGetBundleResouceTool getImage:imageName];
        if (image) {
            [self.imageCahce setValue:image forKey:imageName];
        }
    }
    return image;
}

+ (UIImage*)getImage:(NSString*)imageName{
    NSString *allImageName=imageName;
    if (![imageName hasSuffix:@".png"]) {
        allImageName=[NSString stringWithFormat:@"%@@2x.png",imageName];
    }
    NSString *imagePath = [[YxzGetBundleResouceTool getBundle] pathForResource:allImageName ofType:nil];
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    return img;
}

-(NSMutableDictionary<NSString *,UIImage *> *)imageCahce{
    if (!_imageCahce) {
        _imageCahce=[NSMutableDictionary dictionary];
    }
    return _imageCahce;
}
+ (NSBundle*)getBundle{
    NSString *bundlePaht=[[NSBundle bundleForClass:[YxzGetBundleResouceTool class]] pathForResource:@"YxzChatResouce" ofType:@"bundle"];
    NSBundle *navigationBundle= [NSBundle bundleWithPath:bundlePaht];
    return navigationBundle;
}
+(NSBundle *)faceBundler{
    NSString *bundlePaht=[[NSBundle bundleForClass:[YxzGetBundleResouceTool class]] pathForResource:@"face" ofType:@"bundle"];
    NSBundle *navigationBundle= [NSBundle bundleWithPath:bundlePaht];
    return navigationBundle;
}
-(UIImage *)getFaceWithImageName:(NSString *)imageName{
    UIImage *image=[self.imageCahce objectForKey:imageName];
    if (!image) {
        NSString *allImageName=imageName;
        if (![imageName hasSuffix:@".png"]) {
            allImageName=[NSString stringWithFormat:@"%@@2x.png",imageName];
        }
        NSString *imagePath = [[YxzGetBundleResouceTool faceBundler] pathForResource:allImageName ofType:nil];
        image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            [self.imageCahce setValue:image forKey:imageName];
        }else{
            if (![imageName hasSuffix:@".png"]) {
                allImageName=[NSString stringWithFormat:@"%@@3x.png",imageName];
            }
            NSString *imagePath = [[YxzGetBundleResouceTool faceBundler] pathForResource:allImageName ofType:nil];
            image = [UIImage imageWithContentsOfFile:imagePath];
        }
    }
    return image;
}

+(NSArray<YxzFaceItem *> *)getBundlerFace{
    
    NSString *listPath=[[self faceBundler] pathForResource:@"vy_face" ofType:@"plist"];
    NSArray *array= [NSArray arrayWithContentsOfFile:listPath];
    NSArray *list=[[YxzFaceItem class]mj_objectArrayWithKeyValuesArray:array];
    return list;
}
@end
