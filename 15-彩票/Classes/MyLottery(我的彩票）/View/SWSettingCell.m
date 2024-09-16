//
//  SWSettingCell.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWSettingCell.h"

@implementation SWSettingCell

+(instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary *)item{

    // 解决 cell 重用
    // 创建 celL 的时候 根绝不同的类型 填写不同的 id
    // 下一次复用的时候 只要根据某一个类型的 id 去找那么一定找到的就是对应的类型
    static NSString *cellId = @"";
    if (item[@"cellType"] && [item[@"cellType"] length] > 0) {
        cellId = item[@"cellType"];
    } else {
        cellId = @"setting_cell";
    }

    SWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SWSettingCell alloc] initWithStyle:[self loadCellStyleWithItem:item] reuseIdentifier:cellId];
    }
    return cell;
}

- (void)setItem:(NSDictionary *)item{
    _item = item;
    // 把 数据放到 cell 上
    if (item[@"icon"] && [item[@"icon"] length] > 0) {
        self.imageView.image = [UIImage imageNamed:item[@"icon"]]; // --------设置图片
    }

    self.textLabel.text = item[@"title"]; // -----设置标题

    self.detailTextLabel.text = item[@"subTitle"]; // -----设置子标题
    if (item[@"isRed"] && [item[@"isRed"] boolValue]) {
        self.detailTextLabel.textColor = UIColor.redColor;  // -----设置子标题的颜色
    }

    // 根据字符串生成对象
    NSString *accessoryType = item[@"accessoryType"]; // 获取到 UISwith的字符串
    Class Clz = NSClassFromString(accessoryType); // 获取 UISwitch的类型 UISwitch
//    UISwitch *switcher = [[Clz alloc] init];  // 获取 UISwitch类型的对象
    UIView *obj = [[Clz alloc] init];
    // 判断 obi 真实的类型
    if ([obj isKindOfClass:[UIImageView class]]) {
        // 设置 frame，图片
        UIImageView *imageView = (UIImageView *)obj;
        imageView.image = [UIImage imageNamed:item[@"accessoryContent"]];
        // 自适应图片大小
        [imageView sizeToFit];
    } else if ([obj isKindOfClass:[UISwitch class]]){
        // 如果是开关的类型 那么监听
        UISwitch *switcher = (UISwitch *) obj;
        [switcher addTarget:self action:@selector(switcherChange:) forControlEvents:UIControlEventValueChanged];

        // 从 ud 读取开关状态
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        switcher.on = [ud boolForKey:item[@"switchKye"]];

    }
    // 右边的内容
    self.accessoryView = obj;  // -------设置右边箭头
}

/// 开关状态改变的时候调用
-(void)switcherChange:(UISwitch *)sender{
    // ud 单例
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // 保存
    [ud setBool:sender.isOn forKey:self.item[@"switchKye"]];
}

/// 根据传人的 celL 的类型 返回需要创建的 cell 的类型
+ (UITableViewCellStyle)loadCellStyleWithItem:(NSDictionary *)item{

    if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        return UITableViewCellStyleSubtitle;
    } else if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleValue1"]) {
        return UITableViewCellStyleValue1;
    }else if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleValue2"]) {
        return UITableViewCellStyleValue2;
    } else {
        return UITableViewCellStyleDefault;
    }
}

@end
