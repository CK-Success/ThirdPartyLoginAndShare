//
//  thirdShare.h
//  第三方分享以及登陆
//
//  Created by NewBest_RD on 2017/7/21.
//  Copyright © 2017年 newbest. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,showBottomType)
{

    BottomNormalType      = 0, //
    BottomCircleType      = 1, //
    MiddleNormalType      = 2,//
    MiddleCircleType      = 3,//
 
};

typedef NS_ENUM(NSUInteger, UMS_SHARE_TYPE)
{
    UMS_SHARE_TYPE_TEXT,//纯文本
    UMS_SHARE_TYPE_IMAGE,//本地图片
    UMS_SHARE_TYPE_IMAGE_URL,//HTTPS网络图片
    UMS_SHARE_TYPE_TEXT_IMAGE,//文本+图片
    UMS_SHARE_TYPE_WEB_LINK,//网页链接
    UMS_SHARE_TYPE_MUSIC_LINK,//音乐链接
    UMS_SHARE_TYPE_MUSIC,//本地音乐
    UMS_SHARE_TYPE_VIDEO_LINK,//视频连接
    UMS_SHARE_TYPE_VIDEO,//本地视频
    UMS_SHARE_TYPE_EMOTION,//Gif表情
    UMS_SHARE_TYPE_FILE,//文件
    UMS_SHARE_TYPE_MINI_PROGRAM//微信小程序    
};

@interface thirdShare : NSObject


+(void)showBottomCircleView:(showBottomType)type testType:(UMS_SHARE_TYPE)shareType dict:(NSMutableDictionary *)dataDict;


@end
