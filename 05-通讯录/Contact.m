//
//  Contact.m
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import "Contact.h"

@implementation Contact
+ (BOOL)supportsSecureCoding{
    return true;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_number forKey:@"number"];
}



- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder { 
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.number = [coder decodeObjectForKey:@"number"];
    }
    return self;
}

@end
