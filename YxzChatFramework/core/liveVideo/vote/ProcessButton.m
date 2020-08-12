//
//  ProcessButton.m
//  ProcessButton
//
//  Created by 颜学宙 on 2020/8/11.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "ProcessButton.h"

@implementation ProcessButton

// 设置进度
- (void)setProcess:(float)process {
    _process = process;
    // 设置文字
//    [self setTitle:[NSString stringWithFormat:@"%0.2f%%", process * 100] forState:UIControlStateNormal];
    // 重绘
    [self setNeedsDisplay];
}

// 使用贝塞尔曲线画圆
- (void)drawRect:(CGRect)rect {
    // 创建一个贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat centerY=CGRectGetHeight(rect)/2.0f;
    CGPoint startPoint=CGPointMake(0, centerY);
    [path moveToPoint:startPoint];
    
    CGFloat endX=CGRectGetWidth(rect)*self.process;
    [path addLineToPoint:CGPointMake(endX, centerY)];
    path.lineWidth=CGRectGetHeight(rect);
    
    // 设置线的颜色
    [[UIColor orangeColor] setStroke];
    // 绘画
    [path stroke];
}
@end
