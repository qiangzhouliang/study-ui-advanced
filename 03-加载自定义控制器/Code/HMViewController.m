//
//  HMViewController.m
//  03-加载自定义控制器
//
//  Created by swan on 2024/9/6.
//

#import "HMViewController.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)loadView{
    NSLog(@"loadView");
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
