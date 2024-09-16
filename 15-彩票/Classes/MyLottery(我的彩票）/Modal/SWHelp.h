//
//  SWHelp.h
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHelp : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *html;

@property (nonatomic, strong) NSString *ids;

+ (instancetype)helpWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
