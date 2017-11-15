//
//  APMClickViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMClickViewController.h"
#import "APMTouchView.h"
#import "APMIndicateView.h"
#import "APMIndicateViewHelper.h"

@interface APMClickViewController ()
@property (weak, nonatomic) IBOutlet APMTouchView *touchView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *apmLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *controlBtn;

@property (nonatomic,assign) BOOL tag;

@property (nonatomic,assign) float time;
@property (nonatomic,assign) float score;
@end

@implementation APMClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.touchView.layer.cornerRadius = 0.5*([UIScreen mainScreen].bounds.size.width-100);
    self.touchView.clipsToBounds = YES;
    self.touchView.clickBlock = ^(float time,int clickCount){
        self.time = time;
            self.timeLabel.text = [NSString stringWithFormat:@"%.2fs",self.time];
            float scale = 60.0/time;
            self.score = clickCount*scale;
            self.apmLabel.text = [NSString stringWithFormat:@"%.2f/min",self.score];
            self.clickCountLabel.text = [NSString stringWithFormat:@"%d",clickCount];
    };
    [self.controlBtn addTarget:self action:@selector(dealControl) forControlEvents:UIControlEventTouchDown];
    
}

- (IBAction)dealUpdateClickScore:(id)sender {
    //已经登录则上传成绩
    if([APMHelper getID]){
        NSDictionary *para = @{@"id":[APMHelper getID],@"best_click_score":[NSNumber numberWithFloat:self.score],@"best_click_time":[NSNumber numberWithFloat:self.time]};
        [APMHelper APMPOST:URL_UPLOAD_CLICK_SCORE parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            int state = [dic[@"state"] intValue];
            if(state){
                [MBProgressHUD showSuccess:@"上传成绩成功"];
            }else{
                [MBProgressHUD showError:@"上传成绩失败"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"上传成绩失败"];
        }];
    }
    //未登录则跳转到登录界面
    if(![APMHelper getID]){
        APMLoginViewController *loginV = (APMLoginViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMLoginViewController"];
        APMNavigationController *loginN = [[APMNavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:loginN animated:YES completion:^{
            
        }];
    }
}

- (IBAction)dealScore:(id)sender {
    //已经登录则上传成绩
    if([APMHelper getID]){
        UIViewController *vc = [APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMClickScoreViewController"];
        [self.navigationController pushViewController:vc animated:true];
    }
    //未登录则跳转到登录界面
    if(![APMHelper getID]){
        APMLoginViewController *loginV = (APMLoginViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMLoginViewController"];
        APMNavigationController *loginN = [[APMNavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:loginN animated:YES completion:^{
            
        }];
    }
}


- (void)dealControl{
    if(self.tag){
        [self.controlBtn setTitle:@"START" forState:UIControlStateNormal];
        [self.touchView stop];
    }else{
        self.timeLabel.text = @"0.0s";
        self.apmLabel.text = @"0/min";
        self.clickCountLabel.text = @"0";
        [self.controlBtn setTitle:@"END" forState:UIControlStateNormal];
        self.time = 0.0;
        self.score = 0.0;
        [self.touchView preForStart];
    }
    self.tag = !self.tag;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(![APMHelper getIndicateClick]){
        APMIndicateView *indicate = [APMIndicateViewHelper getIndicateViewWith:@"点击指引"];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:indicate];
        [APMHelper setIndicateClick];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
