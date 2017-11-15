//
//  APMLoginViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMLoginViewController.h"
#import "APMRegisterViewController.h"
#import "APMUUserInfoViewController.h"
#import "AESCrypt.h"

@interface APMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation APMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNum.text = [APMHelper getAccount];
    // Do any additional setup after loading the view.
}
- (IBAction)dealLogin:(id)sender {
    if(![self checkAccountAndPassword]){
        return;
    }
    NSString *password = [AESCrypt encrypt:self.password.text password:@"123hello123"];
    NSDictionary *para = @{@"account":_phoneNum.text,@"password":password,@"D5A315C8F202":@"1A4205DF"};
    [APMHelper APMPOST:URL_LOGIN parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            [APMHelper setAccout:self.phoneNum.text];
            NSString *ID = dic[@"data"][@"id"];
            int length = (int)[ID length];
            ID = [ID substringWithRange:NSMakeRange(8, length-13)];
            [APMHelper setID:ID];
            [MBProgressHUD showSuccess:@"登录成功"];
            APMUUserInfoViewController *userInfo = (APMUUserInfoViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMUUserInfoViewController"];
            [self.navigationController pushViewController:userInfo animated:YES];
            
        }else{
            [MBProgressHUD showError:@"登录失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"登录出错"];
    }];
}

- (BOOL)checkAccountAndPassword{
    BOOL phone = [APMHelper checkMobile:self.phoneNum.text];
    if(!phone){
        [MBProgressHUD showError:@"手机号格式出错"];
        return false;
    }
    return true;
}

- (IBAction)dealRegister:(id)sender {
    APMRegisterViewController *registerV = (APMRegisterViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMRegisterViewController"];
    [self.navigationController pushViewController:registerV animated:YES];
}

- (IBAction)dealForgetPassword:(id)sender {
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
