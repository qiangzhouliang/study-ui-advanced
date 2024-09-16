//
//  SWSettingCell.h
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWSettingCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *item;

+(instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary *)item;

/// 根据传人的 celL 的类型 返回需要创建的 cell 的类型
+ (UITableViewCellStyle)loadCellStyleWithItem:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
