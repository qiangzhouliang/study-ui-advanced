//
//  SWSaveTool.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWSaveTool.h"

@implementation SWSaveTool

+ (id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
}

@end
