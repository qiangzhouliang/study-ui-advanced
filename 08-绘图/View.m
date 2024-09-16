//
//  View.m
//  08-绘图的步骤
//
//  Created by swan on 2024/9/9.
//

#import "View.h"

@implementation View

/*
 1. 代码为什么要写在 drawRect 当中
    因为在这个方法当中可以获取到正确的上下文
 
 2. rect 参数的含义
    当前 view 的bounds
 
 3. drawRect 什么时候调用
    1. 当这个 view 第一次显示的时候 会调用
    2. 当这个 view 重绘的时候 会调用
 
 4. 如何重绘
    4.1 调用某个需要重绘的 view 对象的 setNeedsDisplay
    4.2 调用某个需要重绘的 view 对象的 setNeedsDisplayInRect  rect:需要重绘的区域
 
 5. 为什么不能手动调用 drawRect
    手动调用的时候可能获取不到正确的上下文
 */
- (void)drawRect:(CGRect)rect {
    // 1. c代码
    [self drawImgCut:rect];
}

/// 绘制图片-裁剪
- (void)drawImgCut:(CGRect)rect{
    // 1. 绘制图片（小图）
    UIImage *image = [UIImage imageNamed:@"qiangge"];
    
    // 先画出来显示的区域
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 150, 150, 150, 0, 2 * M_PI, 1);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 2. 绘制
    // 拉伸显示到 view 上
    [image drawInRect:rect];
}

/// 绘制图片
- (void)drawImg:(CGRect)rect{
    // 1. 绘制图片（小图）
    UIImage *image = [UIImage imageNamed:@"word"];
    
    // 2. 绘制
    // 从某一个点开始绘制
//    [image drawAtPoint:CGPointMake(50, 50)];
    
    // 绘制到某一个区域(拉伸）
//    [image drawInRect:rect];
    
    // 平铺到某一个区域
    [image drawAsPatternInRect:rect];
    
}

/// 绘制文字
- (void)drawText:(CGRect)rect{
    // 1. 文字
    NSString *str = @"你好，世界";
    
    // 2. 绘制
    // 2.1 从某一个点开始绘制
    [str drawAtPoint:CGPointZero withAttributes: @{
        NSFontAttributeName: [UIFont systemFontOfSize:30],
        NSForegroundColorAttributeName: UIColor.redColor,
        NSBackgroundColorAttributeName: UIColor.greenColor,
        NSUnderlineStyleAttributeName: @1
    }];
    // 2.2 绘制到指定区域
//    [str drawInRect:rect withAttributes:nil];
}

/// 绘图的样式1 - c
- (void)test_style1 {
    // 1. 获取当前绘图上下文（layer）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 拼接路径 同时 把路径添加到上下文当中
    CGContextMoveToPoint(ctx, 50, 50); // 起点
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 50); // 终点
    CGContextClosePath(ctx);
    
    // 线宽
    CGContextSetLineWidth(ctx, 10);
    
    // 连接处的样式
    //kCGLineJoinMiter,  // 默认
    //kCGLineJoinRound,  // 圆角
    //kCGLineJoinBevel   // 切角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    // 头尾的样式
    //kCGLineCapButt,    // 默认
    //kCGLineCapRound,   // 圆角
    //kCGLineCapSquare   //
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    // 设置颜色 0 - 1 之间
//    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    [[UIColor greenColor] setStroke];
    
    
    
    // 3. 渲染
//    CGContextStrokePath(ctx); // 描边
//    CGContextFillPath(ctx);   // 填充
    
    // 既描边 又 填充
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

/// oc 代码绘制
- (void)test_oc {
    // 2. 拼接路径 (OC)
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    // 3. 渲染
    [path stroke];
}


/// c + oc 代码绘制
- (void)test_c_oc2 {
    // 1. 获取当前绘图上下文（layer）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 拼接路径 (C)
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    // 拼接路径
    UIBezierPath *path1 = [UIBezierPath bezierPathWithCGPath:path];
    [path1 addLineToPoint:CGPointMake(150, 50)];
    
    // 3. 把路径添加到上下文当中(如何把 oc 的 path 转成c的 path)
    CGContextAddPath(ctx, path1.CGPath);
    
    // 3. 渲染
    CGContextStrokePath(ctx);
    // 释放
    CGPathRelease(path);
}


/// c + oc 代码绘制
- (void)test_c_oc {
    // 1. 获取当前绘图上下文（layer）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 拼接路径 (OC)
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    // 3. 把路径添加到上下文当中(如何把 oc 的 path 转成c的 path)
    CGContextAddPath(ctx, path.CGPath);
    
    // 3. 渲染
    CGContextStrokePath(ctx);
}

/// c代码绘制
- (void)test_c2 {
    // 1. 获取当前绘图上下文（layer）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    // 3. 把路径添加到上下文当中
    CGContextAddPath(ctx, path);
    
    // 3. 渲染
    CGContextStrokePath(ctx);
    
    // 释放
    CGPathRelease(path);
}

/// c代码绘制
- (void)test_c {
    // 1. 获取当前绘图上下文（layer）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 拼接路径 同时 把路径添加到上下文当中
    CGContextMoveToPoint(ctx, 50, 50); // 起点
    CGContextAddLineToPoint(ctx, 100, 100); // 终点
    
    // 3. 渲染
    CGContextStrokePath(ctx);
}
@end
