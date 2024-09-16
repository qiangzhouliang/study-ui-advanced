//
//  SWView.h
//  12-小画板
//
//  Created by swan on 2024/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWView : UIView

// 线宽
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

/// 清屏
-(void)clearAll;

/// 回退
-(void)back;

/// 橡皮
-(void)eraser;

@end

NS_ASSUME_NONNULL_END
