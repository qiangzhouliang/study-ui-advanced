//
//  UIView+Frame.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setX:(CGFloat)x{
    // 获取 label 的frame
    CGRect labelRect = self.frame;
    // 修改结构体
    labelRect.origin.x = x;
    // 赋值
    self.frame = labelRect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    // 获取 label 的frame
    CGRect labelRect = self.frame;
    // 修改结构体
    labelRect.origin.y = y;
    // 赋值
    self.frame = labelRect;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setW:(CGFloat)w{
    // 获取 label 的frame
    CGRect labelRect = self.frame;
    // 修改结构体
    labelRect.size.width = w;
    // 赋值
    self.frame = labelRect;
}
-(CGFloat)w{
    return self.frame.size.width;
}


-(void)setH:(CGFloat)h{
    // 获取 label 的frame
    CGRect labelRect = self.frame;
    // 修改结构体
    labelRect.size.height = h;
    // 赋值
    self.frame = labelRect;
}
-(CGFloat)h{
    return self.frame.size.height;
}

@end
