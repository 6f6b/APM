//
//  APMNavigationController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMNavigationController.h"
#import "APMLoginViewController.h"
#import "APMUUserInfoViewController.h"
#import "APMLuViewController.h"
#import "APMClickViewController.h"

#import "APMClickScoreViewController.h"
#import "APMLuScoreViewController.h"
#import "APMVersionViewController.h"
@interface APMNavigationController ()

@end

@implementation APMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    if([viewController isKindOfClass:[APMClickScoreViewController class]]|
       [viewController isKindOfClass:[APMLuScoreViewController class]]|
       [viewController isKindOfClass:[APMVersionViewController class]]){
        [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(dealLeftItem) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [super pushViewController:viewController animated:YES];
}

- (void)dealLeftItem{
    UIViewController *vc = self.viewControllers.lastObject;
    if([vc isKindOfClass:[APMLoginViewController class]]
       || [vc isKindOfClass:[APMUUserInfoViewController class]]
       || [vc isKindOfClass:[APMLuViewController class]]
       || [vc isKindOfClass:[APMClickViewController class]]){
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self popViewControllerAnimated:true];
    }
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
