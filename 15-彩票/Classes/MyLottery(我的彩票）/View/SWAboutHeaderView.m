//
//  SWAboutHeaderView.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWAboutHeaderView.h"

@implementation SWAboutHeaderView

+(instancetype)aboutHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:@"SWAboutHeaderView" owner:nil options:nil][0];
}

@end
