//
//  ProgressViewController.m
//  08-绘图
//
//  Created by swan on 2024/9/9.
//

#import "ProgressViewController.h"
#import "ProgressView.h"

@interface ProgressViewController ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 监听 slider
- (IBAction)ProgressChange:(UISlider *)sender {
    NSLog(@"%f",sender.value);
    self.progressView.progressValue = sender.value;
}


@end
