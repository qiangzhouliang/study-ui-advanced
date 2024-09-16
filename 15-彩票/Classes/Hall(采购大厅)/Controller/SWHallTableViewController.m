//
//  SWHallTableViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/13.
//

#import "SWHallTableViewController.h"

@interface SWHallTableViewController ()

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SWHallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"CS50_activity_image"];
    // 高速系统 使用这张照片的时间不进行渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建 item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage: image style:UIBarButtonItemStylePlain target:self action:@selector(activityClick)];
    self.navigationItem.leftBarButtonItem = item;
    
}

/// 活动的点击事件
-(void)activityClick{
    // 遮罩
    UIView *coverView = [[UIView alloc] initWithFrame:self.view.frame];
    coverView.backgroundColor = UIColor.grayColor;
    coverView.alpha = 0.5;
    // 添加到最外层 控制器
    [self.tabBarController.view addSubview:coverView];
    self.coverView = coverView;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaopingguo"]];
    // 开启用户交互
    imageView.userInteractionEnabled = YES;
    imageView.center = self.view.center;
    // 注意：不添加到 cover 上的原因 是因为 父控件如果透明 那么子控件也会透明
    [self.tabBarController.view addSubview:imageView];
    self.imageView = imageView;
    
    // 关闭按钮
    UIButton *closeButton = [[UIButton alloc]init];
    // 获取图片
    UIImage *clocseButtonImage = [UIImage imageNamed:@"alphaClose"];
    closeButton.frame = CGRectMake(imageView.bounds.size.width - clocseButtonImage.size.width, 0, 0, 0);
    [closeButton setBackgroundImage:clocseButtonImage forState:UIControlStateNormal];
    // 根据图片设置自己的宽高
    [closeButton sizeToFit];
    [imageView addSubview:closeButton];
    // 添加监听事件
    [closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
}

/// 弹框 关闭按钮点击事件
-(void) closeClick {
    [UIView animateWithDuration:0.25 animations:^{
            [self.imageView removeFromSuperview];
            [self.coverView removeFromSuperview];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
