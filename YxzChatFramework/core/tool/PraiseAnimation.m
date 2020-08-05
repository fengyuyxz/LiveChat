//
//  PraiseAnimation.m
//  ParticleAnimationDome
//
//  Created by 颜学宙 on 2020/8/3.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "PraiseAnimation.h"
#import "YXZConstant.h"
@interface PraiseImageView : UIImageView<CAAnimationDelegate>
@property(nonatomic,assign)float x_left_swing;
@property(nonatomic,assign)float x_right_swing; //左右摆动幅度
@property(nonatomic,assign)float animation_h;//动画最高运动高度
@property(nonatomic,assign)float speed;//速度


@end
@implementation PraiseImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _speed=5;
        _animation_h=300;
    }
    return self;
}
-(void)shootingStarAnimate{
    CGFloat duration = 1.6f;
    CGMutablePathRef path = CGPathCreateMutable();
    int width = CGRectGetWidth(self.superview.bounds)/2;
    int fromX       = arc4random_uniform(width)+width/4;     //起始位置:x轴上随机生成一个位置
    int fromY       = -arc4random_uniform(50)+20;//arc4random() % 400; //起始位置:生成位于福袋上方的随机一个y坐标
    
    CGFloat positionX   = fromX+200;    //终点x
    CGFloat positionY   = CGRectGetHeight(self.superview.bounds)+100;    //终点y
    
    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, fromY);
    CGPathAddLineToPoint(path, nil, positionX, positionY);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.delegate=self;
    animation.duration=duration;
    [animation setPath:path];
    CFRelease(path);
    path = nil;
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.repeatDuration=3;//动画持续时间
    group.animations = @[animation];
    
    [self.layer addAnimation:group forKey:nil];
    
}
-(void)animate{
    CGFloat animationDuration=arc4random_uniform(3)+_speed;
    
    CGFloat min=self.x_left_swing;
    CGFloat random = self.x_right_swing - min;
    self.alpha = 0;
    CABasicAnimation *scaleAnimate =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimate.duration = 0.2;
    scaleAnimate.fromValue = @0.2;
    scaleAnimate.toValue = @1;
    CAKeyframeAnimation *xAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    xAnimate.duration = animationDuration;
    xAnimate.values = @[@(self.layer.position.x),@(arc4random_uniform(random)+min),@(arc4random_uniform(random)+min),@(arc4random_uniform(random)+min)];
    
    
    CABasicAnimation *yAnimate=[CABasicAnimation animationWithKeyPath:@"position.y"];
    yAnimate.duration=animationDuration;
    yAnimate.fromValue=@(self.frame.origin.y);
    yAnimate.toValue=@(self.frame.origin.y-self.animation_h);
    
    yAnimate.delegate=self;
    
    CABasicAnimation *opacityAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration=animationDuration;
    opacityAnimation.fromValue=@(1);
    opacityAnimation.toValue=@(0);
    opacityAnimation.repeatCount=1;
    
    yAnimate.fillMode = kCAFillModeForwards;
    yAnimate.removedOnCompletion = NO;
    
    
    xAnimate.fillMode = kCAFillModeForwards;
    xAnimate.removedOnCompletion = NO;
    
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    
    scaleAnimate.fillMode = kCAFillModeForwards;
    scaleAnimate.removedOnCompletion = NO;
    
    [self.layer addAnimation:opacityAnimation forKey:nil];
    [self.layer addAnimation:scaleAnimate forKey:nil];
    [self.layer addAnimation:xAnimate forKey:nil];
    [self.layer addAnimation:yAnimate forKey:nil];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.hidden=YES;
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
    
}
@end


@interface PraiseAnimation()<CAAnimationDelegate>
{
    NSMutableArray  *_coinTagsArr;  //存放生成的所有红包对应的tag值
}
@property(nonatomic,weak)UIView *containerView;

@property(nonatomic,strong)NSArray<UIImage *> *imgArray;
@end
@implementation PraiseAnimation
-(instancetype)initWithImageArray:(NSArray<UIImage *>*)imgArray onView:(UIView *)view startAnimationPoint:(CGPoint)startPoint{
    if (self=[super init]) {
        _containerView=view;
        _startPoint=startPoint;
        _imgArray=imgArray;
        _speed=5;
        _imageSize=CGSizeMake(25, 25);
        _animation_h=200;
        _coinTagsArr=[NSMutableArray array];
    }
    return self;
}
-(void)animate:(NSInteger)count{
    if (count==0) {
        count=1;
    }
    for (int i=0; i<count; i++) {
        int arrayCount = (int)self.imgArray.count;
        NSInteger index=arc4random_uniform(arrayCount);
        UIImage *imge=self.imgArray[index];
        PraiseImageView *prasie=[[PraiseImageView alloc]initWithImage:imge];
        prasie.frame=CGRectMake(self.startPoint.x, self.startPoint.y, self.imageSize.width, self.imageSize.height);
        prasie.speed=self.speed;
        prasie.x_left_swing=self.startPoint.x-self.x_left_swing;
        prasie.x_right_swing=CGRectGetMaxX(prasie.frame)+self.x_right_swing;
        prasie.animation_h=self.animation_h;
        [self.containerView addSubview:prasie];
        [prasie animate];
    }
}


-(void)whaleSprayAnimation{
    UIImage *image=[UIImage imageNamed:@"star"];
    [self shootFrom:self.startPoint Level:10 Cells:@[image]];
}
-(void)starAnimation:(int)count{
    for (int i=1; i<=count; i++) {
//        [self initXingViewWithInt:@(i)];
        [self performSelector:@selector(startStar) withObject:nil afterDelay:i*0.2];
        
    }
}
-(void)startStar{
    PraiseImageView *prasie=[[PraiseImageView alloc]initWithImage:YxzSuperPlayerImage(@"star")];
    [self.containerView addSubview:prasie];
    [prasie shootingStarAnimate];
}
- (void)shootFrom:(CGPoint)position Level:(int)level Cells:(NSArray <UIImage *>*)images{
    
    CGPoint emiterPosition = position;
    // 配置发射器
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = emiterPosition;
    //发射源的尺寸大小
    emitterLayer.emitterSize     = CGSizeMake(10, 10);
    //发射模式
    emitterLayer.emitterMode     = kCAEmitterLayerOutline;
    //发射源的形状
    emitterLayer.emitterShape    = kCAEmitterLayerLine;
    emitterLayer.renderMode      = kCAEmitterLayerOldestLast;
    
    [self.containerView.layer addSublayer:emitterLayer];
    
    int index = rand()%[images count];
    CAEmitterCell *snowflake          = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name                    = @"sprite";
    //粒子参数的速度乘数因子
    snowflake.birthRate               = level;
    snowflake.lifetime                = 10;
    //粒子速度
    snowflake.velocity                = 200;
    //粒子的速度范围
    snowflake.velocityRange           = 500;
    //粒子y方向的加速度分量
    snowflake.yAcceleration           = 300;
    //snowflake.xAcceleration = 200;
    //周围发射角度
    snowflake.emissionRange           = 0.15*M_PI;
    //    snowflake.emissionLatitude = 200;
    snowflake.emissionLongitude       = 2*M_PI;//
    //子旋转角度范围
    snowflake.spinRange               = 2*M_PI;
    
    snowflake.contents                = (id)[[images objectAtIndex:index] CGImage];
    snowflake.contentsScale = 1;
    snowflake.scale                   = 0.2;
    snowflake.scaleSpeed              = 0.1;
    
    
    emitterLayer.emitterCells  = [NSArray arrayWithObject:snowflake];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        emitterLayer.birthRate = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [emitterLayer removeFromSuperlayer];
            
        });
    });
    
}
@end
