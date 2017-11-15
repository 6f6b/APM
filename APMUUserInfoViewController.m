//
//  APMUUserInfoViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMUUserInfoViewController.h"

@interface APMUUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *name;
@property (weak, nonatomic) IBOutlet UIButton *sex;


@end

@implementation APMUUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)dealName:(id)sender {
}
- (IBAction)dealSex:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *para = @{@"id":[APMHelper getID]};
    [APMHelper APMPOST:URL_GET_USERINFO parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            NSString *name = (NSString *)dic[@"data"][@"username"];
            int sex = [dic[@"data"][@"sex"] intValue];
            [self.name setTitle:name forState:UIControlStateNormal];
            if(sex == 0){
                [self.sex setImage:[UIImage imageNamed:@"sex_man"] forState:UIControlStateNormal];
            }
            if(sex == 1){
                [self.sex setImage:[UIImage imageNamed:@"sex_women"] forState:UIControlStateNormal];
            }
            if(sex == 2){
                [self.sex setImage:[UIImage imageNamed:@"sex_nuknown"] forState:UIControlStateNormal];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误");
    }];
}


@end
