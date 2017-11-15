//
//  APMChangeNameViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMChangeNameViewController.h"

@interface APMChangeNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation APMChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dealupdateName:(id)sender {
    NSString *name = self.username.text;
    NSDictionary *para = @{@"id":[APMHelper getID],@"username":name};
    [APMHelper APMPOST:URL_CHANGE_NAME parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
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
