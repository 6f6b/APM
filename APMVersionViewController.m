//
//  APMVersionViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/19.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMVersionViewController.h"

@interface APMVersionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *developerInfoLabel;

@end

@implementation APMVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.developerInfoLabel.alpha = 0;
    // Do any additional setup after loading the view.
}
- (IBAction)dealSignOut:(id)sender {
    [APMHelper setID:@""];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)dealShowDeveloperInfo:(id)sender {
    if(self.developerInfoLabel.hidden != 0){
        return;
    }
    self.developerInfoLabel.alpha = 1;
    [UIView animateWithDuration:4 animations:^{
        self.developerInfoLabel.alpha = 0;
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
