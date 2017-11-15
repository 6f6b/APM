//
//  APMClickScoreViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMClickScoreViewController.h"
#import "APMShareSelectViewController.h"

@interface APMClickScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic,weak) APMShareSelectViewController *shareSelectVC;
@end

@implementation APMClickScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    APMShareSelectViewController *shareSelect = (APMShareSelectViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMShareSelectViewController"];
    shareSelect.view.hidden = true;
    [self addChildViewController:shareSelect];
    [self.view addSubview:shareSelect.view];
    shareSelect.type = 1;
    self.shareSelectVC = shareSelect;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *para = @{@"id":[APMHelper getID]};
    [APMHelper APMPOST:URL_GET_CLICK_SCORE parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            NSArray *arr = dic[@"data"];
            if(arr.count>1){
                int total = [arr[1][@"total"] floatValue];
                float time = [arr[1][@"time"] floatValue];
                float score = [arr[1][@"score"] floatValue];
                int rank = [arr[1][@"rank"] intValue];
                float prescore = [arr[0][@"score"] floatValue];
                
                float percent = (total-rank)*100/(float)total;
                self.timeLabel.text = [NSString stringWithFormat:@"%.2fs",time];
                self.scoreLabel.text = [NSString stringWithFormat:@"%.2f/min",score];
                NSString *info = [NSString stringWithFormat:@"你当前的最快滑动速度超过了全国 %d 名玩家中的 %.3f%@的玩家！位列第 %d 名！你前一名的成绩是 %.3f/min,快去挑战自己的极限吧！",total,percent,@"%",rank,prescore];
                self.infoLabel.text = info;
                
                self.shareSelectVC.total = total;
                self.shareSelectVC.time = time;
                self.shareSelectVC.score = score;
                self.shareSelectVC.rank = rank;
                self.shareSelectVC.percent = percent;
                self.shareSelectVC.prescore = prescore;
            }else{
                int total = [arr[0][@"total"] floatValue];
                float time = [arr[0][@"time"] floatValue];
                float score = [arr[0][@"score"] floatValue];
                int rank = [arr[0][@"rank"] intValue];
                
                float percent = (total-rank)*100/(float)total;
                self.timeLabel.text = [NSString stringWithFormat:@"%.2fs",time];
                self.scoreLabel.text = [NSString stringWithFormat:@"%.2f/min",score];
                NSString *info = [NSString stringWithFormat:@"你当前的最快点击速度超过了全国%d名玩家中的%.3f%@的玩家！位列第%d名！快去挑战自己的极限吧！",total,percent,@"%",rank];
                self.infoLabel.text = info;
                
                self.shareSelectVC.total = total;
                self.shareSelectVC.time = time;
                self.shareSelectVC.score = score;
                self.shareSelectVC.rank = rank;
                self.shareSelectVC.percent = percent;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误");
    }];
}
- (IBAction)dealShare:(id)sender {
    if(!self.shareSelectVC.view.hidden){
        return;
    }
    self.shareSelectVC.view.hidden = false;
    self.shareSelectVC.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.shareSelectVC.view.alpha = 1;
    }];    
}


@end
