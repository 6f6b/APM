//
//  APMShareSelectViewController.m
//  APM
//
//  Created by dev.liufeng on 2016/10/22.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMShareSelectViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface APMShareSelectViewController ()
@property (weak, nonatomic) IBOutlet UIView *stackView;
@property (nonatomic,copy) NSString *url;
@end

@implementation APMShareSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dealShareWechat:(id)sender {
    NSString *parameter = [NSString stringWithFormat:@"type=%d&score=%f&rank=%d&total=%d&percent=%f",_type,_score,_rank,_total,_percent];
    NSString *preUrl = URL_SHARED;
    self.url = [preUrl stringByAppendingString:parameter];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"手速达人";
    message.description = @"快来手速达人测一测你的手速到底有多快吧！";
    [message setThumbImage:[UIImage imageNamed:@"shareIcon"]];
    WXWebpageObject *page = [WXWebpageObject object];
    page.webpageUrl = self.url;
    message.mediaObject = page;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = 0;
    [WXApi sendReq:req];
}

- (IBAction)dealShareCircle:(id)sender {
    NSString *parameter = [NSString stringWithFormat:@"type=%d&score=%f&rank=%d&total=%d&percent=%f",_type,_score,_rank,_total,_percent];
    NSString *preUrl = URL_SHARED;
    self.url = [preUrl stringByAppendingString:parameter];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"手速达人";
    message.description = @"快来手速达人测一测你的手速到底有多快吧！";
    [message setThumbImage:[UIImage imageNamed:@"shareIcon"]];
    WXWebpageObject *page = [WXWebpageObject object];
    page.webpageUrl = self.url;
    message.mediaObject = page;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = 1;
    [WXApi sendReq:req];
}
- (IBAction)dealShareQQ:(id)sender {

}
- (IBAction)dealShareQzone:(id)sender {
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self.stackView];
    if(loc.y<0){
        self.view.hidden = true;
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
