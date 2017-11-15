//
//  APMHelper.m
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import "APMHelper.h"

@implementation APMHelper
+ (UIViewController *)getViewControllerFromStoryBoardWith:(NSString *)storyBoardName identifier:(NSString *)identifier{
    return  [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}


+ (NSURLSessionDataTask *)APMPOST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,URLString];
    NSLog(@"%@",url);
    NSLog(@"%@",parameters);
    return  [manager POST:url parameters:parameters progress:uploadProgress success:success failure:failure];
}

+(void)setID:(NSString *)ID{
    [[self userdefaults] setValue:ID forKey:@"userid"];
}

+ (NSString *)getID{
    NSString *userid = [[self userdefaults] valueForKey:@"userid"];
    if([userid length]>0){
        return  userid;
    }
    return nil;
}

+ (void)setAccout:(NSString *)account{
    [[self userdefaults] setValue:account forKey:@"account"];
}

+ (NSString *)getAccount{
    NSString *account = [[self userdefaults] valueForKey:@"account"];
    if([account length]>0){
        return  account;
    }
    return nil;
}

+ (void)setInstalled{
    [[self userdefaults] setValue:@"YES" forKey:@"installed"];
}

+ (BOOL)getInstalled{
    NSString *installed = [[self userdefaults] valueForKey:@"installed"];
    if([installed isEqualToString:@"YES"]){
        return true;
    }
    return false;
}

+ (void)setIndicateClick{
    [[self userdefaults] setValue:@"YES" forKey:@"clickIndicated"];
}

+ (BOOL)getIndicateClick{
    NSString *installed = [[self userdefaults] valueForKey:@"clickIndicated"];
    if([installed isEqualToString:@"YES"]){
        return true;
    }
    return false;
}

+ (void)setIndicatePan{
    [[self userdefaults] setValue:@"YES" forKey:@"panIndicated"];
}

+ (BOOL)getIndicatePan{
    NSString *installed = [[self userdefaults] valueForKey:@"panIndicated"];
    if([installed isEqualToString:@"YES"]){
        return true;
    }
    return false;
}

//判断手机号码格式是否正确
+ (BOOL)checkMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+(BOOL)checkPassWord:(NSString *)password{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return YES ;
    }else
        return NO;
}

+ (NSUserDefaults *)userdefaults{
    return  [NSUserDefaults standardUserDefaults];
}
@end
