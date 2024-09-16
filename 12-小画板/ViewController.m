//
//  ViewController.m
//  12-小画板
//
//  Created by swan on 2024/9/10.
//

#import "ViewController.h"
#import "SWView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SWView *swView;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthProgress;
@property (weak, nonatomic) IBOutlet UIButton *btnGreen;
@property (weak, nonatomic) IBOutlet UIButton *btnBlue;
@property (weak, nonatomic) IBOutlet UIButton *btnRed;

@end

@implementation ViewController

/// 保存到相册
-(IBAction)sace:(id)sender{
    // 1. 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.swView.bounds.size, NO, 0);
    
    // 4. 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3. 截图
    [self.swView.layer renderInContext:ctx];
    
    // 5. 取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6. 保存到相册
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    
    // 2. 关闭上下文
    UIGraphicsEndImageContext();
}

/// 清屏
-(IBAction)clearAll:(id)sender{
    [self.swView clearAll];
}
/// 回退
-(IBAction)back:(id)sender{
    [self.swView back];
}

/// 橡皮
-(IBAction)rubber:(id)sender{
    [self.swView eraser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置默认线宽
    self.swView.lineWidth = self.lineWidthProgress.value;
    
    // 设置按钮背景色
    self.btnGreen.backgroundColor = UIColor.greenColor;
    self.btnBlue.backgroundColor = UIColor.blueColor;
    self.btnRed.backgroundColor = UIColor.redColor;
    
    // 点一下第一个按钮
    [self lineColorChange:self.btnGreen];
}

/// 监听线宽改变
-(IBAction)lineWidthChange:(UISlider *)sender{
    self.swView.lineWidth = sender.value;
}

/// 监听颜色按钮改变
-(IBAction)lineColorChange:(UIButton *)sender{
    self.swView.lineColor = sender.backgroundColor;
}
@end
