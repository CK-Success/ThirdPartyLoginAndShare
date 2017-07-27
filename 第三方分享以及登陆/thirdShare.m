//
//  thirdShare.m
//  第三方分享以及登陆
//
//  Created by NewBest_RD on 2017/7/21.
//  Copyright © 2017年 newbest. All rights reserved.
//

#import "thirdShare.h"
#import "ViewController.h"

#import <UShareUI/UShareUI.h>

@implementation thirdShare
////弹出菜单显示形状和位置
+(void)showBottomCircleView:(showBottomType)type testType:(UMS_SHARE_TYPE)shareType dict:(NSMutableDictionary *)dataDict
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    
    //弹出菜单显示形状和位置
    if (type==BottomNormalType) {
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    }else if (type==BottomCircleType){
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    }else if (type==MiddleNormalType){
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    }else if (type==MiddleCircleType){
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    }
    
    
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [thirdShare runShareWithType:platformType testType:shareType dict:dataDict];
    }];
    
}
//分享的到不同平台的判断
+(void)runShareWithType:(UMSocialPlatformType)type testType:(UMS_SHARE_TYPE)shareType dict:(NSMutableDictionary *)dataDict
{
    
    if (type==UMSocialPlatformType_QQ) {
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_QQ textType:shareType dict:dataDict];
        return;
    }else if (type==UMSocialPlatformType_Qzone){
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_Qzone textType:shareType dict:dataDict];
        return;
    }else if (type==UMSocialPlatformType_WechatSession){
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_WechatSession textType:shareType dict:dataDict];
        return;
    }else if (type==UMSocialPlatformType_WechatTimeLine){
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine textType:shareType dict:dataDict];
        return;
    }else if (type==UMSocialPlatformType_WechatFavorite){
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_WechatFavorite textType:shareType dict:dataDict];
        return;
    }else if (type==UMSocialPlatformType_Sina){
        [thirdShare shareWebPageToPlatformType:UMSocialPlatformType_Sina textType:shareType dict:dataDict];
        return;
    }
    
    
}
//分享的内容格式
+(void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType textType:(UMS_SHARE_TYPE)textType dict:(NSMutableDictionary *)dataDict {

    UMSocialMessageObject *messageObject =[thirdShare backData:textType dict:dataDict];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[ViewController new] completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
    
}

//对不同的内容格式做不同的解析
+(UMSocialMessageObject *)backData:(UMS_SHARE_TYPE )sharetype  dict:(NSDictionary *)dataDict{

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype==UMS_SHARE_TYPE_TEXT) {//纯文本
        messageObject.text=[dataDict objectForKey:@"text"];
    }else if (sharetype==UMS_SHARE_TYPE_IMAGE){//本地图片
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        UIImage * logoIamge=[UIImage imageWithData:[dataDict objectForKey:@"logoIamge"]];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage =logoIamge;//
        [shareObject setShareImage:logoIamge];//如果有缩略图，则设置缩略图本地
        messageObject.shareObject=shareObject;
        
    }else if (sharetype==UMS_SHARE_TYPE_IMAGE_URL){//HTTPS网络图片
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage =[dataDict objectForKey:@"imageUrl"];
        [shareObject setShareImage:[dataDict objectForKey:@"imageUrl"]];
        messageObject.shareObject=shareObject;
        
    }else if (sharetype==UMS_SHARE_TYPE_TEXT_IMAGE){//文本+图片
        messageObject.text=[dataDict objectForKey:@"text"];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        UIImage * logoIamge=[UIImage imageWithData:[dataDict objectForKey:@"logoIamge"]];
        //如果有缩略图，则设置缩略图
            shareObject.thumbImage = logoIamge;
            shareObject.shareImage = logoIamge;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_WEB_LINK){//网页链接
        //创建网页内容对象
        NSString * thumbURL = [dataDict objectForKey:@"thumbWebURL"];
        NSString * title=[dataDict objectForKey:@"title"];
        NSString * desc=[dataDict objectForKey:@"desc"];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl =[dataDict objectForKey:@"WebURL"];;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_MUSIC_LINK){//音乐链接
        //创建音乐内容对象
        NSString* thumbURL =[dataDict objectForKey:@"thumbMusicURL"];
        NSString * title=[dataDict objectForKey:@"title"];
        NSString * desc=[dataDict objectForKey:@"desc"];
        UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:desc thumImage:thumbURL];
        //设置音乐网页播放地址
        shareObject.musicUrl = [dataDict objectForKey:@"musicUrl"];
        shareObject.musicDataUrl = [dataDict objectForKey:@"musicDataUrl"];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_MUSIC){//本地音乐
        
    }else if (sharetype==UMS_SHARE_TYPE_VIDEO_LINK){//视频连接
        NSString* thumbURL =[dataDict objectForKey:@"thumbVideoURL"];
        NSString * title=[dataDict objectForKey:@"title"];
        NSString * desc=[dataDict objectForKey:@"desc"];
        UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:desc thumImage:thumbURL];
        //设置视频网页播放地址
        shareObject.videoUrl = [dataDict objectForKey:@"VideoURL"];;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_VIDEO){//本地视频
        
    }else if (sharetype==UMS_SHARE_TYPE_EMOTION){//Gif表情
        NSString* thumbURL = [dataDict objectForKey:@"thumbGifURL"];
        NSString * title=[dataDict objectForKey:@"title"];
        NSString * desc=[dataDict objectForKey:@"desc"];
        UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:title descr:desc thumImage:thumbURL];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6"
                                                             ofType:@"gif"];
        NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
        shareObject.emotionData = emoticonData;
        
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_FILE){//文件
        NSString* thumbURL = [dataDict objectForKey:@"thumbFileURL"];
        NSString * title=[dataDict objectForKey:@"title"];
        NSString * desc=[dataDict objectForKey:@"desc"];
        UMShareFileObject *shareObject = [UMShareFileObject shareObjectWithTitle:title descr:desc thumImage:thumbURL];
        
        
        NSString *kFileExtension = @"txt";
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"umengFile"
                                                             ofType:kFileExtension];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        shareObject.fileData = fileData;
        shareObject.fileExtension = kFileExtension;
        
        messageObject.shareObject = shareObject;
    }else if (sharetype==UMS_SHARE_TYPE_MINI_PROGRAM){//微信小程序
        
    }

    return messageObject;
    
}



@end
