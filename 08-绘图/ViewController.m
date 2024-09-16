//
//  ViewController.m
//  08-绘图
//
//  Created by swan on 2024/9/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/// 带圆环图片
@property (weak, nonatomic) IBOutlet UIButton *btnCircleImg;

/// 绘制水印
@property (weak, nonatomic) IBOutlet UIButton *btnDrawWatermark;

/// 屏幕截图
@property (weak, nonatomic) IBOutlet UIButton *btnScreenshot;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnCircleImg addTarget:self action:@selector(裁剪带圆环的图片) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnDrawWatermark addTarget:self action:@selector(绘制水印) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnScreenshot addTarget:self action:@selector(屏幕截图) forControlEvents:UIControlEventTouchUpInside];
}

-(void)裁剪带圆环的图片{
    // 3. 获取图片
    UIImage *image = [UIImage imageNamed:@"qiangge"];
    
    // 4. margin
    CGFloat margin = 10;
    
    // 5. 计算上下文大小
    CGSize ctxSize = CGSizeMake(image.size.width + 2 * margin, image.size.height + 2 * margin);
    
    // 1. 开启图片类型图形上下文
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, 0);
    
    // 6. 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 8. 计算圆心
    CGPoint arcCenter = CGPointMake(ctxSize.width * 0.5, ctxSize.height * 0.5);
    
    // 9. 计算半径
    CGFloat radius = (image.size.width + margin) * 0.5;
    
    // 7. 画圆环
    CGContextAddArc(ctx, arcCenter.x, arcCenter.y, radius, 0, 2 * M_PI, 1);
    
    // 10. 设置宽度
    CGContextSetLineWidth(ctx, margin);
    
    // 11. 渲染圆环
    CGContextStrokePath(ctx);
    
    // 12. 画显示的区域
    CGContextAddArc(ctx, arcCenter.x, arcCenter.y, image.size.width * 0.5, 0, 2 * M_PI, 1);
    
    // 13 裁剪显示区域
    CGContextClip(ctx);
    
    // 14. 画图片
    [image drawAtPoint:CGPointMake(margin, margin)];
    
    // 获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 2. 关闭
    UIGraphicsEndImageContext();
    
    // 测试： 把获取到的图片 放到 图片框上
    self.imageView.image = newImage;
    
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


-(void)绘制水印{
    // 3. 获取图片
    UIImage *image = [UIImage imageNamed:@"banner1"];
    
    // 1. 开启图片类型图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 6. 画大图
    [image drawAtPoint:CGPointZero];
    
    // 4. 文字
    NSString *str = @"黑马程序猿";
    
    // 5. 画文字水印
    [str drawAtPoint:CGPointMake(20, 20) withAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:30]
    }];
    
    // 7. 画图片水印
    UIImage *logo = [UIImage imageNamed:@"word"];
    [logo drawAtPoint:CGPointMake(image.size.width * 0.9, image.size.height * 0.8)];
    
    // 获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 2. 关闭
    UIGraphicsEndImageContext();
    
    // 测试： 把获取到的图片 放到 图片框上
    self.imageView.image = newImage;
    
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)屏幕截图{
    // 1. 开启图片类型图形上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    // 获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 截图 把view 的内容 放到上下文中 然后 渲染
    [self.view.layer renderInContext:ctx];
    
    // 获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 2. 关闭
    UIGraphicsEndImageContext();
    
    // 测试： 把获取到的图片 放到 图片框上
    self.imageView.image = newImage;
    
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存完成");
}


// 屏幕触摸监听
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 1. 获取图片
    UIImage *image = [UIImage imageNamed:@"qiangge"];
    
    // 2. 开启图片类型的图形上下文
    // 第三个参数：0：表示根据屏幕大小生成图片大小
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 3. 画一个裁剪的图形
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5, 0, 2 * M_PI, 1);
    
    // 4. 裁剪
    CGContextClip(ctx);
    
    // 5. 把图片绘制上去
    [image drawAtPoint:CGPointZero];
    
    // 6. 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7. 关闭
    UIGraphicsEndImageContext();
    
    // 测试： 把获取到的图片 放到 图片框上
    self.imageView.image = newImage;
    
    // ***************保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    // ***************保存到沙盒
    // 获取沙盒路径 doc
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    // 获取文件路径
    NSString *filePath = [path stringByAppendingPathComponent:@"xx.png"];
    
    // 1. 先把 image 对象转换成 nsdata
    NSData *data =  UIImagePNGRepresentation(newImage);
    
    // 2. 通过 data 的 write to file 写入到沙盒中
    [data writeToFile:filePath atomically:YES];
    NSLog(@"%@", path);
    
}





@end
