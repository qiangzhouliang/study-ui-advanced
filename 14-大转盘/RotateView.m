//
//  RotateView.m
//  14-大转盘
//
//  Created by swan on 2024/9/11.
//

#import "RotateView.h"

@interface RotateView ()

/// 锯齿图片
@property (weak, nonatomic) IBOutlet UIImageView *rotateImage;
@property (nonatomic, weak) UIButton* currentBtn;

@property (nonatomic, strong) CADisplayLink *link;

@end


@implementation RotateView


/// 初始化加载xib文件
+(instancetype)rotateView {
    return [[NSBundle mainBundle] loadNibNamed:@"RotateView" owner:nil options:nil][0];
}


/// 创建 12 个 btn
- (void)awakeFromNib{
    [super awakeFromNib];
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] init];
        
        // 设置旋转tag
        btn.tag = i;
//        btn.backgroundColor = UIColor.redColor;
        
        // 获取需要设置的图片
        UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
        // 裁剪 image
        image = [self clipImageWithImage:image withIndex:i];
        // 设置图片
        [btn setImage:image forState:UIControlStateNormal];
        
        // 获取需要设置的图片
        UIImage *imagePress = [UIImage imageNamed:@"LuckyAstrologyPressed"];
        // 裁剪 image
        imagePress = [self clipImageWithImage:imagePress withIndex:i];
        // 设置图片
        [btn setImage:imagePress forState:UIControlStateSelected];
        
        // 设置背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        // btn 内部 imageView 往上偏移
        // 15 以上用这个
        UIButtonConfiguration *config = btn.configuration;
        config.contentInsets = NSDirectionalEdgeInsetsMake(-50, 0, 0, 0);
        btn.configuration = config;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-50, 0, 0, 0)];
        
        
        // 添加到view上
        [self.rotateImage addSubview:btn];
        
        // 监听 btn 点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
/// 开始选号
- (IBAction)pickNumber:(id)sender {
    
    // 如果动画已存在，不在实现创建动画代码
    if ([self.rotateImage.layer animationForKey:@"key"]) {
        return;
    }
    
    // 停止自转
    self.link.paused = YES;
    
    // 核心动画 - 基本动画
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    
    // 修改属性
    anim.keyPath = @"transform.rotation";
    
    // 计算需要减去的角度
    CGFloat angle = M_PI * 2 / 12 * self.currentBtn.tag;
    
    // 5 圈
    anim.toValue = @(5 * M_PI * 2 - angle);
    
    // 设置时间
    anim.duration = 3;
    
    // 不回到原来位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    // 把核心动画添加到 image 上
    [self.rotateImage.layer addAnimation:anim forKey:@"key"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 让按钮旋转到最初始的位置
        self.rotateImage.transform = CGAffineTransformMakeRotation(-angle);
        
        // 弹框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你中了一辆兰博基尼" preferredStyle:UIAlertControllerStyleAlert];
        // 创建UIAlertAction，用于处理按钮点击事件
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:true completion:nil];
            // 开启自转
            self.link.paused = NO;
        }];
        // 将UIAlertAction添加到UIAlertController
        [alertController addAction:alertAction];
        
        //创建用于显示alertController的UIViewController
        UIViewController *alertVC = [[UIViewController alloc]init];
        [self addSubview:alertVC.view];
        [alertVC presentViewController:alertController animated:YES completion:^{
          //移除用于显示alertController的UIViewController
          [alertVC.view removeFromSuperview];
        }];
        
        // 移出核心动画
        [self.rotateImage.layer removeAnimationForKey:@"key"];
    });
    
    
    
}

/// 开始旋转
-(void) startRotate{
    if (self.link) return;
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    // 添加到主运行循环中
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

// 旋转
- (void) rotate{
    // 2*mpi 一秒钟60圈
    // 2 * mpi / 60 ’一秒钟1圈
    // 2 *mpi / 60 / 10 十秒钟一圈
    
    self.rotateImage.transform = CGAffineTransformRotate(self.rotateImage.transform, 2 *M_PI / 60 /10);
}

/// 星座按钮点击事件
-(void)btnClick: (UIButton *) sender {
    // 把记录的按钮的选中状态取消
    self.currentBtn.selected = NO;
    // 设置点击按钮被选中
    sender.selected = YES;
    
    //记录当前按钮
    self.currentBtn = sender;
}

/// 布局子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < self.rotateImage.subviews.count; i++) {
        // 获取 button
        UIButton *btn = self.rotateImage.subviews[i];
        
        // 设置中心
        btn.center = self.rotateImage.center;
        
        // 设置 frame
        btn.bounds = CGRectMake(0, 0, 68, 143);
        
        // 锚点
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        
        // 计算一个按钮的夹角
        CGFloat angle = 2 * M_PI / 12;
        // 修改按钮的Transform
        btn.transform = CGAffineTransformMakeRotation(angle * i);
    }
    
}

/// 根据大图 切割出来一部分
-(UIImage*)clipImageWithImage:(UIImage *)image withIndex:(NSInteger)index{
    // 计算rect UIScreen.mainScreen.scale -> 屏幕的缩放因子
    CGFloat w = image.size.width / 12;
    CGFloat h = image.size.height;
    CGFloat x = index * w;
    CGFloat y = 0;
    NSLog(@"%lf", UIScreen.mainScreen.scale);
    
    CGImageRef img = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(x, y, w, h));
    NSLog(@"%@", NSStringFromCGRect(CGRectMake(x, y, w, h)));
    return [[UIImage alloc] initWithCGImage:img scale:2.3 orientation:UIImageOrientationUp];
}

@end
