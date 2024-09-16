//
//  ViewController.m
//  16-获取硬件信息
//
//  Created by swan on 2024/9/16.
//

#import "ViewController.h"
#import "SystemServices.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Log all System Information
    SystemServices *sys = [SystemServices sharedServices];
    NSLog(@"All System Information: %@", sys.cfuuid);
}


@end
