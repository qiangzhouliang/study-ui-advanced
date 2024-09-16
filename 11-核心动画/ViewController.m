//
//  ViewController.m
//  11-核心动画
//
//  Created by swan on 2024/9/10.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRedView];
}

-(void)createRedView{
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 20, 20);
    redView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:redView];
    self.redView = redView;
    self.layer = redView.layer;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self 基本动画];
//    [self 关键帧动画];
    [self 组动画];
}

-(void)组动画{
    // 1. 创建动画对象
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    // --------------基本动画（自旋转）-------------
    // 1. 创建动画对象（做什么动画）
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    
    // 2. 怎么做动画
    anim.keyPath = @"transform.rotation";
    // 在自身的基础上去累加
    anim.byValue = @(2 * M_PI);
    // --------------基本动画（自旋转）-------------
    
    // --------------关键帧动画（绕着圆转）-------------
    // 1. 创建动画对象
    CAKeyframeAnimation *anim1 = [[CAKeyframeAnimation alloc] init];
    
    // 2. 怎么做动画
    anim1.keyPath = @"position";
    
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:2 * M_PI clockwise:1];
    
    anim1.path = path.CGPath;  // 路径
    // --------------关键帧动画（绕着圆转）-------------
    
    // 2.操作
    group.animations = @[anim, anim1];
    // 时间
    group.duration = 3;
    group.repeatCount = INT_MAX;
    
    // 3. 添加动画（对谁做动画）
    [self.layer addAnimation:group forKey:nil];
}

-(void)基本动画{
    // 1. 创建动画对象
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    
    // 2. 怎么做动画
    anim.keyPath = @"position.x";
//    anim.fromValue = @10; 从哪
//    anim.toValue = @300;  到那
    // 在自身的基础上去累加
    anim.byValue = @10;
    
    // 不希望回到原来的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    // 3. 添加动画（对谁做动画）
    [self.layer addAnimation:anim forKey:nil];
}



-(void)关键帧动画{
    // 1. 创建动画对象
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
    
    // 2. 怎么做动画
    anim.keyPath = @"position";
    
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
//    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
//    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
//    anim.values = @[v1, v2, v3, v4];
    
    //----------------------------------
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:150 startAngle:0 endAngle:2 * M_PI clockwise:1];
    
    anim.path = path.CGPath;  // 路径
    
    anim.duration = 2; // 时间
    anim.repeatCount = INT_MAX; // 重复次数
    
    // 不希望回到原来的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    // 3. 添加动画（对谁做动画）
    [self.layer addAnimation:anim forKey:nil];
}
@end
