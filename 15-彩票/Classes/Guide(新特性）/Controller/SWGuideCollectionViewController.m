//
//  SWGuideCollectionViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWGuideCollectionViewController.h"
#import "SWGuideCell.h"
#import "SWTabBarController.h"

@interface SWGuideCollectionViewController ()

@property (nonatomic, weak) UIImageView *largeImageView;
@property (nonatomic, weak) UIImageView *largeTextImageView;
@property (nonatomic, weak) UIImageView *smallTextImageView;

@property (nonatomic, assign) int page; // 记录上一次的页数，用来判断方向

@end

@implementation SWGuideCollectionViewController

static NSString * const reuseIdentifier = @"guide_Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // item 大小
    layout.itemSize = KScreenSize.size;

    // 间距
    layout.minimumLineSpacing = 0;

    // 滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 注册单元格
    [self.collectionView registerClass:[SWGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // 分页
    self.collectionView.pagingEnabled = YES;

    // 取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;

    // 取消弹性效果
    self.collectionView.bounces = NO;

    // 大图片
    UIImageView *largeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    self.largeImageView = largeImageView;

    // 大文字
    UIImageView *largeTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    largeTextImageView.y = KScreenHeight * 0.75;
    self.largeTextImageView = largeTextImageView;

    // 小文字
    UIImageView *smallTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    smallTextImageView.y = KScreenHeight * 0.85;
    self.smallTextImageView = smallTextImageView;

    // 把图片添加到 collectionView 中
    [self.collectionView addSubview:largeImageView];
    [self.collectionView addSubview:largeTextImageView];
    [self.collectionView addSubview:smallTextImageView];

    // 添加波浪线图片
    UIImage *image = [UIImage imageNamed:@"guideLine"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.x = -220;
    [self.collectionView addSubview:imageView];

    // 添加立即体验按钮
    UIButton *enterButton = [[UIButton alloc] init];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [enterButton sizeToFit];
    enterButton.x = 3 * KScreenWidth + (KScreenWidth - enterButton.w) * 0.5;
    enterButton.y = KScreenHeight * 0.9;
    [self.collectionView addSubview:enterButton];
    // 监听 立即体验按钮点击事件
    [enterButton addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
}

/// 立即体验按钮点击事件
-(void)enterClick{
    // 创建 tabbarController
    SWTabBarController *tab = [[SWTabBarController alloc] init];

    // 切换window 的根控制器
    UIWindow *win = [UIApplication sharedApplication].windows[0];
    win.rootViewController = tab;
}

#pragma mark <UICollectionViewDataSource>
/// 监听 collectionView 滑动完成（scrolLView减速完成）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 获取到 scrollView 的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获取页数
    int page = offsetX / KScreenWidth;
    // 获取 图片名字
    NSString *largeImageName = [NSString stringWithFormat:@"guide%d", page+1];
    NSString *largeTextImageName = [NSString stringWithFormat:@"guideLargeText%d", page+1];
    NSString *smailTextImageName = [NSString stringWithFormat:@"guideSmallText%d", page+1];

    // 跟换图片
    self.largeImageView.image = [UIImage imageNamed:largeImageName];
    self.largeTextImageView.image = [UIImage imageNamed:largeTextImageName];
    self.smallTextImageView.image = [UIImage imageNamed:smailTextImageName];

    // 判断方向
    if (self.page > page) {
        // 在做动画之前 先改变图片的x,实现图片出来的方式和滑动页面的方式相同
        // 从左往右
        self.largeImageView.x = offsetX - KScreenWidth;
        self.largeTextImageView.x = offsetX - KScreenWidth;
        self.smallTextImageView.x = offsetX - KScreenWidth;
    } else {
        // 在做动画之前 先改变图片的x,实现图片出来的方式和滑动页面的方式相同
        // 从右往左
        self.largeImageView.x = offsetX + KScreenWidth;
        self.largeTextImageView.x = offsetX + KScreenWidth;
        self.smallTextImageView.x = offsetX + KScreenWidth;
    }

    // 加特技
    [UIView animateWithDuration:0.25 animations:^{
        self.largeImageView.x = offsetX;
        self.largeTextImageView.x = offsetX;
        self.smallTextImageView.x = offsetX;
    }];
    self.page = page;


}

/// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/// 每一组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

/// cell 样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 去缓存池找
    SWGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // 获取图片
    NSString *imageName = [NSString stringWithFormat:@"guide%zdBackground", indexPath.row + 1];
    UIImage *image = [UIImage imageNamed:imageName];

    // 把数据传给 cell
    cell.image = image;

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
