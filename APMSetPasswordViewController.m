//
//  APMSetPasswordViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMSetPasswordViewController.h"
#import "APMUUserInfoViewController.h"
#import "AESCrypt.h"

@interface APMSetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@end

@implementation APMSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dealFinished:(id)sender {
    if(![self checkPassword]){
        return;
    }
    NSString *password = [AESCrypt encrypt:self.pwd.text password:@"123hello123"];
    NSDictionary *para = @{@"account":self.account,@"password":password,@"sex":[NSNumber numberWithInt:2],@"username":@"用户名",@"D5A315C8F202":@"1A4205DF"};
    [APMHelper APMPOST:URL_REGISTER parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        int state = [dic[@"state"] intValue];
        if(state){
            NSString *ID = dic[@"data"][@"id"];
            int length = (int)[ID length];
            ID = [ID substringWithRange:NSMakeRange(8, length-13)];
            [APMHelper setID:ID];
            [MBProgressHUD showSuccess:@"注册成功"];
            APMUUserInfoViewController *userInfo = (APMUUserInfoViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMUUserInfoViewController"];
            [self.navigationController pushViewController:userInfo animated:YES];
            
        }else{
            [MBProgressHUD showError:@"注册失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"注册失败"];
    }];
}

- (BOOL)checkPassword{
    if(![_pwd.text isEqual:_confirmPwd.text]){
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return false;
    }
    if([_pwd.text length] == 0){
        [MBProgressHUD showError:@"密码不能为空"];
        return false;
    }
    if(![APMHelper checkPassWord:_pwd.text]){
        [MBProgressHUD showError:@"密码格式错误"];
        return false;
    }
    return true;
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
