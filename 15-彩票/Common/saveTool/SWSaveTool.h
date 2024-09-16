//
//  SWSaveTool.h
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWSaveTool : NSObject

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
