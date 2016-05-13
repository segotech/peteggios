//
//  AppDelegate+ShareSDK.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate+ShareSDK.h"

@implementation AppDelegate (ShareSDK)

/**
 *  shareSDK的初始化
 */
- (void)shareSDKApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    [ShareSDK registerApp:@"85d250655d35"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"449565157"
                                        appSecret:@"5af4c81f3d1f17a2c7054fc0d6813796"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx33a86d5926a50bdd"
                                       appSecret:@"6a3d1ca67089314014fc273f58ff960f"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105167571"
                                      appKey:@"I0n690K9Vc0BfTDE"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
 
}

@end
