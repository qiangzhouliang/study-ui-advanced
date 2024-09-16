//
//  SWView.m
//  09-触摸事件
//
//  Created by swan on 2024/9/10.
//

#import "SWView.h"

#define kButtonCount 9

@interface SWView ()

/// 9 个按钮
@property (nonatomic, strong) NSMutableArray *btns;

/// 所以需要连线的按钮
@property (nonatomic, strong) NSMutableArray *lineBtns;

/// 当前手指的位置
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation SWView

- (NSMutableArray *)lineBtns{
    if (!_lineBtns) {
        _lineBtns = [NSMutableArray array];
    }
    return _lineBtns;
}

-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
        
        for (int i = 0; i < kButtonCount; i++) {
            // 创建 9 哥button
            UIButton *btn = [[UIButton alloc]init];
            
            // 给 btn 设置个 tag （生成密码）
            btn.tag = i;
            
            // 设置默认图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            
            // 设置高亮
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            
            // 设置btn错误的图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            
            // 静止用户交互
            [btn setUserInteractionEnabled:NO];
            
            [self addSubview:btn];
            // 把创建的按钮添加到数组中 方便管理
            [self.btns addObject:btn];
        }
    }
    return _btns;
}

/// 手指触摸到这个 view 的时候调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1. 获取触摸对象
    UITouch *t = touches.anyObject;
    // 2. 获取手指位置
    CGPoint p = [t locationInView:t.view];
    
    // 3. 判断手指的位置释放在这个按钮内
    for (int i = 0; i < self.btns.count; i++) {
        // 获取 btn
        UIButton *btn = self.btns[i];
        
        // 如果 btn 的 frame 包含 手指的点
        if (CGRectContainsPoint(btn.frame, p)) {
            // 让按钮亮起来
            btn.selected = YES;
            // 添加到需要划线的数组当中
            [self.lineBtns addObject:btn];
        }
    }
}

/// 手指在这个 view 上移动的时候调用
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1. 获取触摸对象
    UITouch *t = touches.anyObject;
    // 2. 获取手指位置
    self.currentPoint = [t locationInView:t.view];
    
    // 3. 判断手指的位置释放在这个按钮内
    for (int i = 0; i < self.btns.count; i++) {
        // 获取 btn
        UIButton *btn = self.btns[i];
        
        // 如果 btn 的 frame 包含 手指的点
        if (CGRectContainsPoint(btn.frame, self.currentPoint)) {
            // 让按钮亮起来
            btn.selected = YES;
            // 判断 如果已经加到了数组中，就不在添加
            if (![self.lineBtns containsObject:btn]) {
                // 添加到需要划线的数组当中
                [self.lineBtns addObject:btn];
            }
        }
    }
    
    // 重绘
    [self setNeedsDisplay];
}

// 手指离开
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 修改最后手指的位置为需要连线的最后一个按钮的中心 解决最后一根线多出来的问题
    self.currentPoint = [[self.lineBtns lastObject] center];
    // 重绘
    [self setNeedsDisplay];
    
    // 所有需要画线的 btn 都变成错误的样式
    for (int i = 0; i < self.lineBtns.count; i++) {
        // 获取 btn
        UIButton *btn = self.lineBtns[i];
        btn.selected = NO;
        // 设置button 错误状态
        btn.enabled = NO;
    }
    
    // 拼接密码
    NSString *password = @"";
    for (int i = 0; i < self.lineBtns.count; i++) {
        // 获取 btn
        UIButton *btn = self.lineBtns[i];
        password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld", btn.tag]];
    }
    // 把生成的密码交给 Block
    if (self.passwordBlock) {
        if (self.passwordBlock(password)) {
            NSLog(@"zhengque");
        } else {
            NSLog(@"cuowo");
        }
    }
    
    // 关闭用户交互
    [self setUserInteractionEnabled:NO];
    
    // 等 2s 后 清空
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        // 开启用户交互
        [self setUserInteractionEnabled:YES];
    });
}

/// 清空（恢复到最初始状态）
-(void)clear{
    for (int i = 0; i < self.btns.count; i++) {
        // 获取 btn
        UIButton *btn = self.btns[i];
        // 取消按钮的高亮状态
        btn.selected = NO;
        // 设置按钮可用状态
        btn.enabled = YES;
    }
    // 清空需要连线的按钮
    [self.lineBtns removeAllObjects];
    // 重绘
    [self setNeedsDisplay];
}

/// 画线
- (void)drawRect:(CGRect)rect{
    
    // 如果没有需要划线的按钮，name不需要执行
    if (!self.lineBtns.count) {
        return;
    }
    
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.lineBtns.count; i++) {
        // 获取 btn
        UIButton *btn = self.lineBtns[i];
        
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 画当前手指的位置
    [path addLineToPoint:self.currentPoint];
    
    // 设置颜色
    [UIColor.whiteColor set];
    [path setLineWidth:10];
    
    // 设置连接处的样式
    [path setLineJoinStyle:kCGLineJoinRound];
    
    // 设置头尾样式
    [path setLineCapStyle:kCGLineCapRound];
    
    // 渲染
    [path stroke];
}

// 无论是从 sb 还是 xib 都会调用
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    
//}

/// 计算九宫格
-(void)layoutSubviews{
    [super layoutSubviews];
    // 计算九宫格的位置
    CGFloat w = 74;
    CGFloat h = w;
    int colCount = 3;
    CGFloat margin = (self.frame.size.width - 3 * w) / 4;
    for (int i = 0; i < self.btns.count; i++) {
        CGFloat x = (i % colCount) * (margin + w) + margin;
        CGFloat y = (i / colCount) * (margin + w) + margin;
        [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
    }
}



@end
