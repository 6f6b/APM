//
//  APMRegisterViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMRegisterViewController.h"
#import "APMSetPasswordViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface APMRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phonenum;
@property (weak, nonatomic) IBOutlet UITextField *verifycode;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int seconde;
@end

@implementation APMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seconde = 10;
    // Do any additional setup after loading the view.
}
- (IBAction)dealGetVerifyCode:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimerGo) userInfo:nil repeats:true];
    self.getVerifyBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.getVerifyBtn.userInteractionEnabled = false;
    [self.getVerifyBtn setTitle:[NSString stringWithFormat:@"%d",self.seconde] forState:UIControlStateNormal];
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phonenum.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            [MBProgressHUD showSuccess:@"验证码发送成功"];
        } else {
            [MBProgressHUD showError:@"验证码发送失败"];
        }
    }];
}

- (void)dealTimerGo{
    if(self.seconde <= 0){
        [self resetGetVerifyBtn];
        return;
    }
    self.seconde -= 1;
    [self.getVerifyBtn setTitle:[NSString stringWithFormat:@"%d",self.seconde] forState:UIControlStateNormal];
}

- (void)resetGetVerifyBtn{
    [self.timer invalidate];
    self.seconde = 10;
    [self.getVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getVerifyBtn.backgroundColor = [UIColor blackColor];
    self.getVerifyBtn.userInteractionEnabled = true;
}

- (IBAction)dealNext:(id)sender {
    if(![APMHelper checkMobile:self.phonenum.text]){
        [MBProgressHUD showError:@"手机号格式错误"];
        return;
    }
    [SMSSDK commitVerificationCode:self.verifycode.text phoneNumber:self.phonenum.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error)
        {
            
            APMSetPasswordViewController *vc = (APMSetPasswordViewController *)[APMHelper getViewControllerFromStoryBoardWith:@"APMLogin" identifier:@"APMSetPasswordViewController"];
            vc.account = self.phonenum.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [MBProgressHUD showSuccess:@"验证失败"];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self resetGetVerifyBtn];
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
