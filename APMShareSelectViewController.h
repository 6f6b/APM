//
//  APMShareSelectViewController.h
//  APM
//
//  Created by dev.liufeng on 2016/10/22.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APMShareSelectViewController : UIViewController
//成绩类型
@property (nonatomic,assign) int type;

//成绩
@property (nonatomic,assign) float score;
//时间
@property (nonatomic,assign) float time;
//排名
@property (nonatomic,assign) int rank;
//百分比
@property (nonatomic,assign) float percent;
//总人数
@property (nonatomic,assign) int total;

//前一名的成绩
@property (nonatomic,assign) float prescore;
@end
