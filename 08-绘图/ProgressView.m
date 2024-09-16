//
//  ProgressView.m
//  08-绘图
//
//  Created by swan on 2024/9/9.
//

#import "ProgressView.h"

@interface ProgressView ()
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;
@end

@implementation ProgressView

-(void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    self.lblProgress.text = [NSString stringWithFormat:@"%.2f%%", progressValue * 100];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 - M_PI_2 endAngle:2 * M_PI * self.progressValue - M_PI_2 clockwise:1];
    
    // 往圆心连线
    [path addLineToPoint:CGPointMake(150, 150)];
    
    [UIColor.redColor set];
    [path fill];
}


@end
