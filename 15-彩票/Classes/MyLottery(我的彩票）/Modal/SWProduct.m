//
//  SWProduct.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWProduct.h"

@implementation SWProduct

+(instancetype) productWithDict: (NSDictionary *) dict{
    SWProduct *p = [[self alloc] init];
    p.title = dict[@"title"];
    p.stitle = dict[@"stitle"];
    p.ids = dict[@"is"];
    p.url = dict[@"url"];
    p.icon = dict[@"icon"];
    p.customUrl = dict[@"customUrl"];
    return p;

}
@end
