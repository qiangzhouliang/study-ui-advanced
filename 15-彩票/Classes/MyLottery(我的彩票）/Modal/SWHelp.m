//
//  SWHelp.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWHelp.h"

@implementation SWHelp

+ (instancetype)helpWithDict:(NSDictionary *)dict
{
    SWHelp *help = [[self alloc] init];
    help.ids = dict[@"id"];
    help.title = dict[@"title"];
    help.html = dict[@"html"];

    return help;

}

@end
