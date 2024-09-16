//
//  SWProduct.h
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWProduct : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *stitle;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *customUrl;

+(instancetype) productWithDict: (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
