//
//  AppDelegate.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Launcher.h"
#import "AppDelegate+ShareSDK.h"
#import "AppDelegate+Sephone.h"
#import "IQKeyboardManager.h"
#import <CoreTelephony/CTCallCenter.h>
#import "PopStartView.h"
@interface AppDelegate ()<GetScrollVDelegate>

//@property (nonatomic, strong) CTCallCenter * center;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //点击背景收起键盘
    [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:YES];
    //影藏键盘上的自定义工具栏
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
        
//     NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    if (![[userdefaults objectForKey:@"STARTFLAG"] isEqualToString:@"1"]) {//第一次启动软件
//        
//        [userdefaults setObject:@"1" forKey:@"STARTFLAG"];
//        [userdefaults synchronize];
//        PopStartView *popStartV = [[PopStartView alloc]initWithFrame:self.window.bounds];
//        popStartV.delegate = self;
//        popStartV.ParentView = self.window;
//        [self.window addSubview:popStartV];
//        
//    }else {//不是第一次启动软件
    
        //初始化启动流程
        [self launcherApplication:application didFinishLaunchingWithOptions:launchOptions];

    //}

    //初始化分享
    
    [self shareSDKApplication:application didFinishLaunchingWithOptions:launchOptions];
    //初始化启动流程
    [self launcherApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self initSephoneVoip:application didFinishLaunchingWithOptions:launchOptions];
    
    
    return YES;
}



//代理函数
- (void)getScrollV:(NSString *)popScroll
{
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    

    
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
