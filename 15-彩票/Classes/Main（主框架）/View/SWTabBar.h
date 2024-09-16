//
//  SWTabBar.h
//  15-彩票
//
//  Created by swan on 2024/9/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTabBar : UIView

// 1.写 block 属性（相当于 代理的 协议，协议方法，id 属性）
@property (nonatomic, copy) void (^tabbatButtonBlock)(NSInteger);


-(void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel;

@end

NS_ASSUME_NONNULL_END
