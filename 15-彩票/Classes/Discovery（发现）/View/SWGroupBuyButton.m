//
//  SWGroupBuyButton.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWGroupBuyButton.h"
#import "UIView+Frame.h"

@implementation SWGroupBuyButton

- (void)layoutSubviews{
    [super layoutSubviews];
    // 交换button 内部控件的位置
    // label x = 0 ------
    self.titleLabel.x = 0;
    
    // imageView x = label.width-------
    self.imageView.x = self.titleLabel.w;
    
    // ------------- ----------------------------
    
    // 获取 label 的frame
//    CGRect labelRect = self.titleLabel.frame;
//    // 修改结构体
//    labelRect.origin.x = 0;
//    // 赋值
//    self.titleLabel.frame = labelRect;
//    
//    self.titleLabel.x = 0;
    
    
    // imageView x = label.width
    // 获取 imageView 的frame
//    CGRect imageViewRect = self.imageView.frame;
//    // 修改结构体
//    imageViewRect.origin.x = labelRect.size.width;
//    // 赋值
//    self.imageView.frame = imageViewRect;
}
@end
