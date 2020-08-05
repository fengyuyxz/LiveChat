//
//  PraiseAnimation.h
//  ParticleAnimationDome
//
//  Created by 颜学宙 on 2020/8/3.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PraiseAnimation : NSObject
@property(nonatomic,assign)float speed;//速度
@property(nonatomic,assign)float x_left_swing;
@property(nonatomic,assign)float x_right_swing; //左右摆动幅度
@property(nonatomic,assign)float animation_h;//动画最高运动高度
@property(nonatomic,assign)CGSize imageSize;//图片大小
@property(nonatomic,assign)CGPoint startPoint;
-(instancetype)initWithImageArray:(NSArray<UIImage *>*)imgArray onView:(UIView *)view startAnimationPoint:(CGPoint)startPoint;

-(void)animate:(NSInteger)count;
-(void)starAnimation:(int)count;
-(void)whaleSprayAnimation;
@end


