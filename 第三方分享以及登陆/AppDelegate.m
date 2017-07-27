//
//  AppDelegate.m
//  第三方分享以及登陆
//
//  Created by NewBest_RD on 2017/7/20.
//  Copyright © 2017年 newbest. All rights reserved.
//

#import "AppDelegate.h"

#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

#define WXSecret @"06662e8f4aafc1bb77d6cfeeb001be8f"
#define WXKey @"wx1153e5035fbdbaf5"

#define QQID @"1106269696"
#define QQKey @"euOYpfw7QKjY56cg"

#define SinaSecret @"8005e43ae709a928b538774ec4a5df59"
#define SinaKey @"1345594648"

#define USHARE_iphone_APPKEY @"5951d150ae1bf86af8000527"
#define USHARE_ipad_APPKEY   @"59704e8575ca352d9c000b43"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_iphone_APPKEY];
    
    [self configUSharePlatforms];
    

//    [self judgeIsExitAPP];
    
    
    
    return YES;
}

-(void)judgeIsExitAPP{

    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Wechat://"]]) {
        //微信
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXKey appSecret:WXSecret redirectURL:nil];
    }
    

    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        //QQ
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    }

    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
        //新浪微博
        
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaKey  appSecret:SinaSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
        
    }
    


}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
