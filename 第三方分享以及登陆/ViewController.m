//
//  ViewController.m
//  第三方分享以及登陆
//
//  Created by NewBest_RD on 2017/7/20.
//  Copyright © 2017年 newbest. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "thirdShare.h"



#define WXSecret @"06662e8f4aafc1bb77d6cfeeb001be8f"
#define WXKey @"wx1153e5035fbdbaf5"

#define QQID @"1106269696"
#define QQKey @"euOYpfw7QKjY56cg"

#define SinaSecret @"8005e43ae709a928b538774ec4a5df59"
#define SinaKey @"1345594648"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)fenxiang:(id)sender {
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    
        
    
    [thirdShare showBottomCircleView:BottomNormalType testType:UMS_SHARE_TYPE_TEXT_IMAGE dict:dict];
    
}

- (IBAction)login:(id)sender {
    
    [self thirdLogin:UMSocialPlatformType_WechatSession];
//    [self thirdLogin:UMSocialPlatformType_QQ];
//    [self thirdLogin:UMSocialPlatformType_Sina];
    
}

-(void)thirdLogin:(UMSocialPlatformType )type{

    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);//具有唯一性
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];



}

     
     
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
