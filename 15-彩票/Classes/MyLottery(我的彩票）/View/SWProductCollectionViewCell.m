//
//  SWProductCollectionViewCell.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWProductCollectionViewCell.h"

@interface SWProductCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;


@end

@implementation SWProductCollectionViewCell


-(void)setProduct:(SWProduct *)product{
    _product = product;

    // 处理圆角
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;

    // 把数据放到对应的控件上
    self.iconView.image = [UIImage imageNamed:product.icon];
    self.titleView.text = product.title;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
