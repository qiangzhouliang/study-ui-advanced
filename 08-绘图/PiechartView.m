//
//  PiechartView.m
//  08-绘图
//  绘制饼状图
//  Created by swan on 2024/9/9.
//

#import "PiechartView.h"

@implementation PiechartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSArray *array = @[@0.3, @0.1, @0.2, @0.4];
    
    CGFloat start = 0;
    CGFloat end = 0;
    for (int i = 0; i < array.count; i++) {
        end = 2 * M_PI * [array[i] floatValue] + start;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 120) radius:100 startAngle:start endAngle: end clockwise:1];
        
        // 往圆心连线
        [path addLineToPoint:CGPointMake(150, 120)];
        
        // 随机颜色
        [[UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:1] set];
        
        [path fill];
        
        // 下一次的起点等于上一次的终点
        start = end;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"我被点击了");
    // 重绘
    [self setNeedsDisplay];
}

@end
