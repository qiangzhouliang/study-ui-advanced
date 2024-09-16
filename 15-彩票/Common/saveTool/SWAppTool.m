//
//  SWAppTool.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWAppTool.h"

@implementation SWAppTool

/// 获取当前APP版本号
+ (NSString *) loadAppVersion {
    // 获取 info 字典
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];

    return curVersion;
}

/// 获取保存了的 appversion
+ (NSString *) loadSaveAppVersion {
    return [SWSaveTool objectForKey:@"appVersion"];
}

/// 把当前的版本号保存到沙盒
+(NSString *)saveAppVersion{
    // 获取 info 字典
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];

//    NSLog(@"infiDic=%@",curVersion);
    // 获取当前程序版本号
    [SWSaveTool setObject:curVersion forKey:@"appVersion"];

    return curVersion;
}
@end
