//
//  ViewController.m
//  10-CALayer
//
//  Created by swan on 2024/9/10.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) CALayer *layer;

@property (nonatomic, weak) CALayer *second;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self 基本属性];
//    [self 手动创建];
    [self 时钟练习];
}

-(void)时钟练习{
    // 设置背景颜色
    self.view.backgroundColor = UIColor.orangeColor;
    
    // 创建一个表盘
    CALayer *clock = [[CALayer alloc] init];
    clock.bounds = CGRectMake(0, 0, 200, 200); // 大小
    clock.position = CGPointMake(200, 200); // 位置
    // 设置圆角
    clock.cornerRadius = 100; // 圆角半径
    clock.masksToBounds = YES; // 裁剪超出部分
    
    // 6 设置内容
    clock.contents = (__bridge id)([UIImage imageNamed:@"clock"].CGImage);
    
    // 创建秒针
    CALayer *senond = [[CALayer alloc] init];
    senond.bounds = CGRectMake(0, 0, 2, 100); // 大小
    senond.position = clock.position;  // 位置
    senond.backgroundColor = UIColor.redColor.CGColor; // 颜色
    // 锚点 定位点 (0 -  1) 之间
    senond.anchorPoint = CGPointMake(0.5, 0.8);
    
    // 把 layer 添加到 控制器 view 的 layer上
    // 添加表盘
    [self.view.layer addSublayer:clock];
    // 添加秒针
    [self.view.layer addSublayer:senond];
    self.second = senond;
    
    // 计时器
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    // 显示连接
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self timeChange];
}

/// 进行选择 1s 一次
-(void)timeChange{
    // 旋转角度
    CGFloat angle = 2 * M_PI / 60;
    
    // 获取当前时间
    // 1. NSDate
    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"ss";
//    CGFloat time = [[formatter stringFromDate:date] floatValue];
    
    // 2. 日历
    NSCalendar *cal = [NSCalendar currentCalendar];
    CGFloat time = [cal component:NSCalendarUnitSecond fromDate:date];
    
    
    
    // 设置转到的角度
    self.second.affineTransform = CGAffineTransformMakeRotation(angle * time);
}

-(void)手动创建{
    CALayer *layer = [[CALayer alloc] init];
    
    layer.backgroundColor = UIColor.redColor.CGColor;
    layer.position = CGPointMake(200, 200); // 位置
    layer.bounds = CGRectMake(0, 0, 100, 100); // 大小
    
    // 6 设置内容
    layer.contents = (__bridge id)([UIImage imageNamed:@"word"].CGImage);
    
    // 把 layer 添加到 控制器 view 的 layer上
    [self.view.layer addSublayer:layer];
    
    self.layer = layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *t = touches.anyObject;
    
//    self.layer.position = [t locationInView:self.view];
    // 旋转
//    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 0, 1, 0);
    // 缩放
//    self.layer.transform = CATransform3DScale(self.layer.transform, 0.5, 1, 1);
    // 平移
    self.layer.transform = CATransform3DTranslate(self.layer.transform, 10, 1, 1);
}


-(void)基本属性{
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 100, 100);
    redView.backgroundColor = UIColor.redColor;
    
    // 设置边框-宽度
    redView.layer.borderWidth = 10;
    redView.layer.borderColor = UIColor.greenColor.CGColor; // 边框颜色
    
    // 2 阴影
    redView.layer.shadowOffset = CGSizeMake(10, 10);//偏移量
    redView.layer.shadowColor = UIColor.blueColor.CGColor; // 阴影颜色
    redView.layer.shadowRadius = 50;  //设置阴影半径
    redView.layer.shadowOpacity = 1; // 设置阴影的透明度
    
    // 3 圆角
    redView.layer.cornerRadius = 50; // 圆角半径
    redView.layer.masksToBounds = YES; // 裁剪超出部分
    
    // 4. bounds
//    redView.layer.bounds = CGRectMake(0, 0, 200, 200);
    
    // 5 postion属性和view.center的关系  // 默认 center 跑到 position的位置上
//    redView.layer.position = CGPointMake(100, 100);
    
    // 6 设置内容
    redView.layer.contents = (__bridge id)([UIImage imageNamed:@"word"].CGImage);
    
    [self.view addSubview:redView];
}

@end
