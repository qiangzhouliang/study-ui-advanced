//
//  SWView.h
//  09-触摸事件
//
//  Created by swan on 2024/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWView : UIView

@property (nonatomic, copy) BOOL(^passwordBlock)(NSString *);

@end

NS_ASSUME_NONNULL_END
