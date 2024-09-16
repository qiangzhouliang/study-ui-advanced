//
//  SWLuckViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWLuckViewController.h"

@interface SWLuckViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SWLuckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置要做动画的图片
    self.imageView.animationImages = @[
        [UIImage imageNamed:@"lucky_entry_light0"],
        [UIImage imageNamed:@"lucky_entry_light1"]
    ];
    // 时间
    self.imageView.animationDuration = 0.5 ;
    // 次数
    self.imageView.animationRepeatCount = 0;
    
    // 开始
    [self.imageView startAnimating];
}



@end
