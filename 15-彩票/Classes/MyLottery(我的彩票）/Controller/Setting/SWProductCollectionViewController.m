//
//  SWProductCollectionViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWProductCollectionViewController.h"
#import "SWProduct.h"
#import "SWProductCollectionViewCell.h"

@interface SWProductCollectionViewController ()

@property (nonatomic, strong) NSArray *products;

@end

@implementation SWProductCollectionViewController

static NSString * const reuseIdentifier = @"product_Cell";

/// 懒加载
-(NSArray *)products{
    if (!_products) {
        // 1. 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more_project" ofType:@"json"];
        // 2.把文件转化成 data
        NSData *data = [NSData dataWithContentsOfFile:path];
        // 3.通过 data 转化成 array
        NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        // 4.初始化一个可变数组
        NSMutableArray *array = [NSMutableArray array];
        // 5.遍历临时数组 获取字典
        for (NSDictionary *dict in tempArray) {
            // 6.通过字典转模型
            SWProduct *p = [SWProduct productWithDict:dict];

            // 7.把模型添加到可变数组当中
            [array addObject:p];
        }

        // 8.赋值
        _products = array;
    }
    return _products;
}

- (instancetype)init{
    // 创建 layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置 layout 参数
    // item 大小
    layout.itemSize = CGSizeMake(80, 80);
    // item 左右最小的距离
    layout.minimumInteritemSpacing = 0;
    // 组内边距
    layout.sectionInset = UIEdgeInsetsMake(16, 0, 0, 0);

    return [super initWithCollectionViewLayout:layout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell nib
    UINib *nib = [UINib nibWithNibName:@"SWProductCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
/// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/// 每一组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // 把模型（数据）传给 cell
    cell.product = self.products[indexPath.row];

    return cell;
}

/// 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SWProduct *p = self.products[indexPath.row];
    NSLog(@"%@", p.stitle);
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
