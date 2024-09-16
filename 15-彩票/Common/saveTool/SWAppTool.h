//
//  SWAppTool.h
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWAppTool : NSObject

/// 获取当前版本号
+ (NSString *) loadAppVersion;
/// 获取保存了的 appversion
+ (NSString *) loadSaveAppVersion;
/// 把当前的版本号保存到沙盒
+(NSString *)saveAppVersion;
@end

NS_ASSUME_NONNULL_END
