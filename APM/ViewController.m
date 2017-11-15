//
//  ViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "APMLoginViewController.h"
#import "APMNavigationController.h"
#import "APMUUserInfoViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIButton *luBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginorminBtn;
@property (weak, nonatomic) IBOutlet UILabel *remindLoginLabel;
@property (weak, nonatomic) IBOutlet UIButton *advertBtn;

@property (strong,nonatomic) NSArray *adeverts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clickBtn.backgroundColor = [UIColor blackColor];
    self.clickBtn.layer.cornerRadius = 5;
    self.clickBtn.clipsToBounds = YES;
    
    self.luBtn.backgroundColor = [UIColor blackColor];
    self.luBtn.layer.cornerRadius = 5;
    self.luBtn.clipsToBounds = YES;
    
    self.loginorminBtn.backgroundColor = [UIColor blackColor];
    self.loginorminBtn.layer.cornerRadius = 5;
    self.loginorminBtn.clipsToBounds = YES;
    
    [APMHelper APMPOST:URL_ADVERT parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            NSArray *adverts = dic[@"data"];
            self.adeverts = adverts;
            if(self.adeverts.count == 0){
                self.advertBtn.hidden = true;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.advertBtn.hidden = true;
        NSLog(@"错误");
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)dealClick:(id)sender {
    UIViewController *vc = [APMHelper getViewControllerFromStoryBoardWith:@"Main" identifier:@"APMClickViewController"];
    APMNavigationController *nav = [[APMNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:true completion:^{
        
    }];
}
- (IBAction)dealLu:(id)sender {
    UIViewController *vc = [APMHelper getViewControllerFromStoryBoardWith:@"Main" identifier:@"APMLuViewController"];
    APMNavigationController *nav = [[APMNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:true completion:^{
        
    }];
}
- (IBAction)dealLoginOrMin:(id)sender {
    //进入登录界面
    if(![APMHelper getID]){
        APMLoginViewController *loginV = (APMLoginViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMLoginViewController"];
        APMNavigationController *loginN = [[APMNavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:loginN animated:YES completion:^{
            
        }];
    }else{
        //进入我的界面
        APMUUserInfoViewController *userVC = (APMUUserInfoViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMUUserInfoViewController"];
        APMNavigationController *userN = [[APMNavigationController alloc] initWithRootViewController:userVC];
        [self presentViewController:userN animated:YES completion:^{
            
        }];
    }
}
- (IBAction)dealAdvert:(id)sender {
    if(self.adeverts.count>0){
        NSLog(@"进入广告界面");
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([APMHelper getID]){
        [self.loginorminBtn setTitle:@"个人中心" forState:UIControlStateNormal];
        self.remindLoginLabel.hidden = true;
    }else{
        [self.loginorminBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.remindLoginLabel.hidden = false;
    }
    NSLog(@"%@",[APMHelper getID]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
