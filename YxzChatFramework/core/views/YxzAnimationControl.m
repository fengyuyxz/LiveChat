//
//  YxzAnimationControl.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/1.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzAnimationControl.h"
#import "NSString+Empty.h"
#import <CCKeyFrameAnimationView.h>
#define YxzAnimaitonFireworksBundel  @"animationfireworks.bundle"
@implementation YxzAnimationControl
+(NSString *)generateAnimationNums{
    
    int nums=arc4random()%6+1;//生成1 - 6中动画
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for(int i=1;i<=nums;i++){
        NSString *anim=[NSString stringWithFormat:@"%d",(arc4random()%6+1)];
        if (![array containsObject:anim]) {
            [array addObject:anim];
        }
    }
   NSString *animationNums= [array componentsJoinedByString:@","];
    
    return animationNums;
}
+(void)beginAnimation:(NSString *)animationNum animationImageView:(UIView *)animaitnImageView{
    __block NSMutableArray<NSMutableArray *> *imgeArray=[[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          
        float animationDuration =2;
        @autoreleasepool {
            NSArray<NSString *> *animationList;
               if ([animationNum containsString:@","]) {
                   animationList=[animationNum componentsSeparatedByString:@","];
               }else{
                   animationList=@[animationNum];
               }
               NSDictionary *animationfolder=@{@"01":@"16",@"02":@"20",@"03":@"38",@"04":@"34",@"05":@"25",@"06":@"29"};
              
               
               for (NSString *animtionType in animationList) {
                   NSMutableArray<UIImage *> *allImageList=[[NSMutableArray alloc]init];
                   
                   NSString *key=[NSString stringWithFormat:@"0%@",animtionType];
                   NSString *folderName=[NSString stringWithFormat:@"0%@png",animtionType];
                   NSString *imageNums=animationfolder[key];
                   if (![NSString isEmpty:imageNums]) {
                      
                       NSString *imageFolder=[YxzAnimaitonFireworksBundel stringByAppendingPathComponent:folderName];
                       int nums=[imageNums intValue];
                       for (int i=1; i<=nums; i++) {
                           NSString *imageFilePath=[imageFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%d",folderName,i]];
                           UIImage *image=[UIImage imageNamed:imageFilePath];
                           if (image) {
                               [allImageList addObject:image];
                           }
                       }
                   }
                   [imgeArray addObject:allImageList];
               }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0;i<imgeArray.count;i++) {
                UIImageView *img=animaitnImageView.subviews[i];
                img.animationImages = imgeArray[i];
                img.animationDuration = animationDuration;
                img.animationRepeatCount = 1;
                [img startAnimating];
                
            }
            [self checkIsAnimation:animaitnImageView.subviews animationCount:imgeArray.count imgArray:imgeArray];
        });
    });
    
   
}
+(void)checkIsAnimation:(NSArray<UIImageView *> *)list animationCount:(NSInteger)count imgArray:(NSMutableArray<NSMutableArray *> *)array{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger subCount=count;
        for (int i=0; i<array.count; i++) {
            UIImageView *imageView=list[i];
            if (!imageView.isAnimating) {
                [imageView stopAnimating];
                imageView.animationImages=nil;
                subCount--;
            }
        }
        if (subCount==0) {
            for (NSMutableArray *mArr in array) {
                [mArr removeAllObjects];
            }
            [array removeAllObjects];
            NSLog(@"===释放 图片 =====");
        }else{
            [self checkIsAnimation:list animationCount:count imgArray:array];
        }
    });
}
@end
