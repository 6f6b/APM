//
//  APMTouchView.m
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMTouchView.h"

@interface APMTouchView ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int clickCount;
@property (nonatomic,assign) BOOL isStop;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,assign) CGPoint prePoint;
@end
@implementation APMTouchView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.startDate == nil){
        self.prePoint = [[touches anyObject] locationInView:self];
        self.startDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(timerGo) userInfo:nil repeats:true];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentLoc = [[touches anyObject] locationInView:self];
    float distance = (currentLoc.y-self.prePoint.y)*(currentLoc.y-self.prePoint.y)+(currentLoc.x-self.prePoint.x)*(currentLoc.x-self.prePoint.x);
    self.prePoint = currentLoc;
    if(distance>=625){
        return;
    }
    self.clickCount += 1;
}

- (void)timerGo{
    if (self.clickBlock != nil){
        NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        float time = [currentDate timeIntervalSinceReferenceDate]-[self.startDate timeIntervalSinceReferenceDate];
        self.clickBlock(time,self.clickCount);
    }
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
    self.isStop = true;
    self.startDate = nil;
    self.clickCount = 0;
    self.userInteractionEnabled = false;
}

- (void)preForStart{
    self.userInteractionEnabled = true;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.userInteractionEnabled = false;
}
@end
