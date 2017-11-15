//
//  APMTouchView.h
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^StartBlock)();
typedef void (^ClickBlock)(float time,int clickCount);

@interface APMTouchView : UIView
@property (nonatomic,strong) StartBlock startBlock;
@property (nonatomic,strong) ClickBlock clickBlock;

- (void)stop;
- (void)preForStart;
@end
