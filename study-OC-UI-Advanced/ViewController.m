//
//  ViewController.m
//  study-OC-UI-Advanced
//
//  Created by swan on 2024/9/5.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     1. UIApplication 类型的对象 主要是执行应用级别的操作
     2. 应用程序对象的获取 ［UIApplication sharedApplication］
     */
    
    UIApplication *app = [UIApplication sharedApplication];
    
    // keyWindow
//    app.keyWindow  应用之所以能够显示就是因为他的存在
//    app.windows: 应用程序里面所有的可见不可见的window；
}
- (IBAction)lineWidthChange:(UISlider *)sender {
}


@end
