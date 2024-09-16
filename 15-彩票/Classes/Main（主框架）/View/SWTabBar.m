//
//  SWTabBar.m
//  15-彩票
//
//  Created by swan on 2024/9/12.
//

#import "SWTabBar.h"

@interface SWTabBarButton : UIButton

@end

@implementation SWTabBarButton

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end

@interface SWTabBar ()

@property (nonatomic, strong) SWTabBarButton *currentTabBarButton;

@end

@implementation SWTabBar

-(void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel{
    // 创建button
    SWTabBarButton *tabbarButton = [[SWTabBarButton alloc]init];
    
    // 设置背景
    tabbarButton.backgroundColor = UIColor.blackColor;
    
    // 设置图片
    [tabbarButton setImage:image forState:UIControlStateNormal];
    [tabbarButton setImage:imageSel forState:UIControlStateSelected];
    
    // 监听button
    [tabbarButton addTarget:self action:@selector(tabbatButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 添加到自己上
    [self addSubview:tabbarButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) {
        // 获取button
        SWTabBarButton *tabbarButton = self.subviews[i];
        // 设置tag
        tabbarButton.tag = i;
        
        // 设置frame
        
        CGFloat w = KScreenWidth / self.subviews.count;
        CGFloat h = self.frame.size.height;
        CGFloat y =0;
        CGFloat x = i * w;
        tabbarButton.frame = CGRectMake(x, y, w, h);
        
        // 点一下 第一个按钮
        if (i == 0) {
            [self tabbatButtonClick:tabbarButton];
        }
    }
    
}

/// 按钮点击事件
-(void)tabbatButtonClick: (SWTabBarButton *)sender{
    // 取消记录的按钮选中状态
    self.currentTabBarButton.selected = NO;
    // 选中当前点击按钮
    sender.selected = YES;
    // 记录当前按钮
    self.currentTabBarButton = sender;
    
    // 切换选中的控制器
//    self.selectedIndex = sender.tag;
    // 判断 block 是不是有值
    if(self.tabbatButtonBlock){
        self.tabbatButtonBlock(sender.tag);
    }
}

@end
