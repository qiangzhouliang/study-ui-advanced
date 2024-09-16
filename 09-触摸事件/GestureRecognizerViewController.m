//
//  GestureRecognizerViewController.m
//  09-触摸事件-手势识别
//
//  Created by swan on 2024/9/10.
//

#import "GestureRecognizerViewController.h"

@interface GestureRecognizerViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GestureRecognizerViewController

//UITapGestureRecognizer（敲击）
//UILongPressGestureRecognizer（长按）
//UIPinchGestureRecognizer（捏合，用于缩放）
//UIPanGestureRecognizer（拖拽）
//UISwipeGestureRecognizer（轻扫）
//UIRotationGestureRecognizer（旋转）

- (void)viewDidLoad {
    [super viewDidLoad];
    /**********UITapGestureRecognizer（敲击）****************/
    // 1. 创建手势对象
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    // 双击 - 点几次
    tab.numberOfTapsRequired = 2;
    tab.numberOfTouchesRequired = 2; // 几根手指
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:tab];
    
    /**********UILongPressGestureRecognizer（长按）****************/
    // 1. 创建手势对象
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:longPress];
    
    /**********UISwipeGestureRecognizer（轻扫）****************/
    // 默认从左往右滑
    // 1. 创建手势对象
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:swipe];
    
    /**********UIRotationGestureRecognizer（旋转）****************/
    // 默认从左往右滑
    // 1. 创建手势对象
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:rotation];
    
    /********** UIPinchGestureRecognizer（捏合，用于缩放）****************/
    // 默认从左往右滑
    // 1. 创建手势对象
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:pinch];
    
    /********** UIPanGestureRecognizer（拖拽）****************/
    // 默认从左往右滑
    // 1. 创建手势对象
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    // 2. 对某一个 view 添加手势
    [self.imageView addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// 3. 实现手势的方法


-(void)pan:(UIPanGestureRecognizer *)sender {
    CGPoint p = [sender translationInView:sender.view];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, p.x, p.y);
    // 恢复初始状态
    [sender setTranslation:CGPointZero inView:sender.view];
}

-(void)pinch:(UIPinchGestureRecognizer *)sender {
    NSLog(@"UIPinchGestureRecognizer %f",sender.scale);
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale);
    // 恢复初始状态
    sender.scale = 1;
}

-(void)rotation:(UIRotationGestureRecognizer *)sender {
    NSLog(@"UIRotationGestureRecognizer - %f",sender.rotation);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, sender.rotation);
    
//    self.imageView.transform = CGAffineTransformMakeRotation(sender.rotation);
    sender.rotation = 0; // 归零，恢复到最初始的状态
}


-(void)swipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"UISwipeGestureRecognizer");
}

-(void)longPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"你点到我了-UILongPressGestureRecognizer");
    }
}

-(void)tap:(UITapGestureRecognizer *)sender {
    NSLog(@"你点到我了");
}

@end
