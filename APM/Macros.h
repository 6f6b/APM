//
//  Macros.h
//  APM
//
//  Created by dev.liufeng on 2016/10/20.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#ifndef Macros_h
#define Macros_h
//服务器地址
#define URL @"http://www.devlaoguo.top/"

//登录接口
#define URL_LOGIN   @"apm/login.php"

//注册接口
#define URL_REGISTER   @"apm/register.php"

//上传点击成绩接口
#define URL_UPLOAD_CLICK_SCORE   @"apm/uploadclickscore.php"

//上传滑动成绩接口
#define URL_UPLOAD_PAN_SCORE   @"apm/uploadpanscore.php"

//获取点击成绩接口
#define URL_GET_CLICK_SCORE   @"apm/clickscore.php"

//获取滑动成绩接口
#define URL_GET_PAN_SCORE   @"apm/panscore.php"

//广告接口
#define URL_ADVERT   @"apm/advert.php"

//版本接口
#define URL_VERSION   @"apm/version.php"

//修改性别接口
#define URL_CHANGE_SEX   @"apm/updatesex.php"

//修改用户名接口
#define URL_CHANGE_NAME   @"apm/updatename.php"

//用户信息
#define URL_GET_USERINFO   @"apm/userinfo.php"

//安装
#define URL_INSTALLED   @"apm/installed.php"

//分享网页
#define URL_SHARED  [NSString stringWithFormat:@"%@%@",URL,@"apm/shareinfo.php?"]
#endif /* Macros_h */
