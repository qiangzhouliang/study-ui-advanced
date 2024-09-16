//
//  HMProvince.h
//  01-点餐系统
//
//  Created by swan on 2024/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMProvince : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *cities;

- (instancetype) initWithDict: (NSDictionary *)dict;
+ (instancetype) proviceWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
