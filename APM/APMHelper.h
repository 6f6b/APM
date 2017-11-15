//
//  APMHelper.h
//  APM
//
//  Created by dev.liufeng on 2016/10/12.
//  Copyright © 2016年 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APMHelper : NSObject
/**
 *  用于从storyBoard中获取Viewcontroller
 *
 *  @param storyBoardName storyBoard的名字
 *  @param identifier     controller的id
 *
 *  @return 返回获取到的controller
 */
+(UIViewController *)getViewControllerFromStoryBoardWith:(NSString *)storyBoardName identifier:(NSString *)identifier;

/**
 *  全局网络请求函数
 *
 *  @param URLString      url地址
 *  @param parameters     参数
 *  @param uploadProgress
 *  @param success        请求成功回调block
 *  @param failure        请求失败回调block
 *
 *  @return 返回值
 */
+ (NSURLSessionDataTask *)APMPOST:(NSString *)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * _Nonnull uploadProgress))uploadProgress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

/**
 *  存储userid
 *
 *  @param ID userid
 */
+(void)setID:(NSString *)ID;

/**
 *  获取userid
 *
 *  @return 获取本地存储的userid
 */
+ (NSString *)getID;

/**
 *
 */
+ (void)setIndicateClick;
+ (BOOL)getIndicateClick;

+ (void)setIndicatePan;

+ (BOOL)getIndicatePan;

/**
 *  存储手机号
 *
 *  @param 手机号
 */
+(void)setAccout:(NSString *)account;

/**
 *  获取手机号
 *
 *  @return 获取本地存储的手机号
 */
+ (NSString *)getAccount;

/**
 *  判断手机号是否正确
 *
 *  @param mobile 手机号字符串
 *
 *  @return bool值
 */

/**
 *  第一次安装执行
 */
+ (void)setInstalled;

/**
 *  判断是否安装
 *
 *  @return
 */
+ (BOOL)getInstalled;

+ (BOOL)checkMobile:(NSString *)mobile;

/**
 *  检测密码是否合法
 *
 *  @param password 密码字符串
 *
 *  @return bool值
 */
+(BOOL)checkPassWord:(NSString *)password;


@end
