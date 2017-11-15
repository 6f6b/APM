//
//  APMIndicateView.m
//  APM
//
//  Created by dev.liufeng on 2016/11/2.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMIndicateView.h"

@implementation APMIndicateView



- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-110, SCREEN_HEIGHT-50, 100, 40);
    [button setImage:[UIImage imageNamed:@"knowthat"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dealHi) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)dealHi{
    [self removeFromSuperview];
}

@end
