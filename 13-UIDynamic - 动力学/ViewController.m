//
//  ViewController.m
//  13-UIDynamic - 动力学
//
//  Created by swan on 2024/9/11.
//

#import "ViewController.h"

@interface SWView : UIView

@end
@implementation SWView

- (void)drawRect:(CGRect)rect{
//fromPoint:CGPointMake(0, 200) toPoint:CGPointMake(200, 250)
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(200, 250)];
    [path stroke];
}

@end


@interface ViewController ()

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;

@property (nonatomic, strong) UIDynamicAnimator *anim;

@end

@implementation ViewController

-(void)loadView{
    self.view = [[SWView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    redView.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:redView];
    self.redView = redView;
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = UIColor.blueColor;
    blueView.frame = CGRectMake(170, UIScreen.mainScreen.bounds.size.height - 50, 50, 50);
    
    [self.view addSubview:blueView];
    self.blueView = blueView;
}


/// 点击屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self 重力];
    [self 碰撞];
}

-(void) 重力{
    // 1. 根据某一个范围 创建动画者对象
    self.anim = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 2. 根据某一个动力学元素 创建行为
    // 重力行为
    UIGravityBehavior *gracity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    // 方向
//    gracity.angle = M_PI;  // 用角度的形式设置方向
//    gracity.gravityDirection = CGVectorMake(1, 1);
    
    // 量级
    gracity.magnitude = 10;
    
    // 3. 把行为添加到动画者当中
    [self.anim addBehavior:gracity];
}

-(void) 碰撞{
    // 1. 根据某一个范围 创建动画者对象
    self.anim = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 2. 根据某一个动力学元素 创建行为
    // 重力行为
    UIGravityBehavior *gracity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    // 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    // 把引用 view 的 bounds 变成边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 自己创建边界
    // 以一条线为边界
//    [collision addBoundaryWithIdentifier:@"key" fromPoint:CGPointMake(0, 200) toPoint:CGPointMake(200, 250)];
    
    // 以自定义view为边界
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.blueView.frame];
    [collision addBoundaryWithIdentifier:@"key" forPath:path];
    
    // action 实时监听
    collision.action = ^{
        NSLog(@"%@", NSStringFromCGRect(self.redView.frame));
    };
    
    // 碰撞模式
//    UICollisionBehaviorModeItems        // 仅仅item 和 item 之间发生碰撞
//    UICollisionBehaviorModeBoundaries   // 仅仅item 和 边界 之间发生碰撞
//    UICollisionBehaviorModeEverything   // item 和 边界 都发生碰撞
    collision.collisionMode = UICollisionBehaviorModeEverything;
    
    // 3. 把行为添加到动画者当中
    [self.anim addBehavior:gracity];
    [self.anim addBehavior:collision];
}

@end
