//
//  APMChangeSexViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMChangeSexViewController.h"

@interface APMChangeSexViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sex;

@end

@implementation APMChangeSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dealUpdateSex:(id)sender {
    NSInteger sex = self.sex.selectedSegmentIndex;
    NSDictionary *para = @{@"id":[APMHelper getID],@"sex":[NSNumber numberWithUnsignedInteger:sex]};
    [APMHelper APMPOST:URL_CHANGE_SEX parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
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
