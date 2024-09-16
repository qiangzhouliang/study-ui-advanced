//
//  SWGuideCell.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWGuideCell.h"

@interface SWGuideCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SWGuideCell

/// 懒加载创建 imageView
-(UIImageView *) imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:KScreenSize];
        [self addSubview:imageView];

        _imageView = imageView;
    }
    return _imageView;
}


- (void)setImage:(UIImage *)image{
    _image = image;
    // 把数据放在控件中
    self.imageView.image = image;
}

@end
