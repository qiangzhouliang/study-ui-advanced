//
//  HMProvince.m
//  01-点餐系统
//
//  Created by swan on 2024/9/6.
//

#import "HMProvince.h"

@implementation HMProvince

- (instancetype) initWithDict: (NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype) proviceWithDict: (NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
