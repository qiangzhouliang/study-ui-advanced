//
//  SWView.m
//  12-小画板
//
//  Created by swan on 2024/9/10.
//

#import "SWView.h"
#import "SWBezierPath.h"

@interface SWView ()

//@property (nonatomic, strong) SWBezierPath *path;

// 管理路径数组
@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation SWView

- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}
// 懒加载 -  创建路径
//- (SWBezierPath *)path{
//    if (!_path) {
//        _path = [[SWBezierPath alloc] init];
//    }
//    return _path;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    for (SWBezierPath *path in self.paths) {
        // 设置连接处的样式
        [path setLineJoinStyle:kCGLineJoinRound];
        
        // 设置头尾样式
        [path setLineCapStyle:kCGLineCapRound];
        
        // 设置颜色
        [path.lineColor1 set];
        // 渲染
        [path stroke];
    }
}

// 手指在这个 view 上触摸的时候调用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取触摸对象
    UITouch *t = touches.anyObject;
    
    // 获取手指位置
    CGPoint p = [t locationInView:t.view];
    SWBezierPath *path = [[SWBezierPath alloc] init];
    
    // 设置线宽
    [path setLineWidth:self.lineWidth];
    // 设置线的颜色
    path.lineColor1 = self.lineColor;
    
    // 起点
    [path moveToPoint:p];
    
    // 把每一次新创建的路径 添加到数组当中
    [self.paths addObject:path];
}

// 手指在这个 view 上移动的时候调用
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取触摸对象
    UITouch *t = touches.anyObject;
    
    // 获取手指位置
    CGPoint p = [t locationInView:t.view];
    
    // 连线
    [[self.paths lastObject] addLineToPoint:p];
    
    // 重绘
    [self setNeedsDisplay];
    
}


/// 清屏
-(void)clearAll{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

/// 回退
-(void)back{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

/// 橡皮
-(void)eraser{
    self.lineColor = self.backgroundColor;
}
@end
