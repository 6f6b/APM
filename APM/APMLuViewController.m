//
//  APMLuViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMLuViewController.h"
#import "APMIndicateView.h"
#import "APMIndicateViewHelper.h"

@interface APMLuViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *apmLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickCountLabel;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int clickCount;
@property (nonatomic,assign) float score;
@property (nonatomic,assign) float time;
@property (nonatomic,assign) BOOL isStop;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,assign) BOOL isFromBottom;
@property (nonatomic,assign) BOOL isFromTop;
@end

@implementation APMLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setExclusiveTouch:true];
}

- (IBAction)dealUploadPanScore:(id)sender {
    //已经登录则上传成绩
    if([APMHelper getID]){
        NSDictionary *para = @{@"id":[APMHelper getID],@"best_pan_score":[NSNumber numberWithFloat:self.score],@"best_pan_time":[NSNumber numberWithFloat:self.time]};
        [APMHelper APMPOST:URL_UPLOAD_PAN_SCORE parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
            
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

- (IBAction)dealLuscore:(id)sender {
    //已经登录则上传成绩
    if([APMHelper getID]){
        UIViewController *vc = [APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMLuScoreViewController"];
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    [self prepareForstart];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",touches);
    UITouch *touch = [touches anyObject];
    CGPoint point1 = [touch locationInView:_topView];
    CGPoint point2 = [touch locationInView:_bottomView];
    if (point2.y>0){
        self.isFromBottom = YES;
    }
    if(point1.y<self.topView.bounds.size.height){
        self.isFromTop = YES;
    }
    
    if (point1.y<self.topView.bounds.size.height && self.isFromBottom){
        self.clickCount += 1;
        self.isFromBottom = NO;
    }
    if(point2.y>0 && self.isFromTop){
        self.clickCount += 1;
        self.isFromTop = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self stop];
}

- (void)timerGo{
    NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    float time = [currentDate timeIntervalSinceReferenceDate]-[self.startDate timeIntervalSinceReferenceDate];
    self.time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2fs",time];
    
    float scale = 60.0/time;
    self.score = _clickCount*scale;
    self.apmLabel.text = [NSString stringWithFormat:@"%.2f/min",self.score];
    self.clickCountLabel.text = [NSString stringWithFormat:@"%d",_clickCount];
}

- (void)prepareForstart{
    //重置Label
    self.timeLabel.text = [NSString stringWithFormat:@"0.0s"];
    self.apmLabel.text = [NSString stringWithFormat:@"0.00/min"];
    self.clickCountLabel.text = [NSString stringWithFormat:@"0"];
    
    //重置相关属性
    self.clickCount = 0;
    self.score = 0;
    self.time = 0;
    self.isStop = false;
    self.isFromBottom = false;
    self.isFromTop = false;
    self.startDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(timerGo) userInfo:nil repeats:true];
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
    self.isStop = true;
    self.startDate = nil;
    self.clickCount = 0;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(![APMHelper getIndicatePan]){
        APMIndicateView *indicate = [APMIndicateViewHelper getIndicateViewWith:@"滑动指引"];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:indicate];
        [APMHelper setIndicatePan];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
