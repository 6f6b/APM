//
//  APMIndicateViewHelper.m
//  APM
//
//  Created by dev.liufeng on 2016/11/3.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMIndicateViewHelper.h"
#import "APMIndicateView.h"

@implementation APMIndicateViewHelper
+ (UIView *)getIndicateViewWith:(NSString *)image{
    APMIndicateView *indicateView = [[APMIndicateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    indicateView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.frame = indicateView.bounds;
    imageView.alpha = 1;
    [indicateView addSubview:imageView];
    return indicateView;
}
@end
