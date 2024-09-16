//
//  Contact.h
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;

@end

NS_ASSUME_NONNULL_END
