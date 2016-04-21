//
//  AppDelegate+Launcher.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate+Launcher.h"
#import "WasCallViewController.h"

@interface AppDelegate()

@end

@implementation AppDelegate (Launcher)

/**
 *  启动逻辑入口
 *
 *  @param application
 *  @param launchOptions
 */
- (void)launcherApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       GREEN_COLOR,NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotificationLoginStateChange object:nil];
    
    
      
    
    
    
    [self checkLogin];
}

- (void)checkLogin{
    if ([AccountManager sharedAccountManager].isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
    }
}

-(void)loginStateChange:(NSNotification *)notification{
    
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {
        [self enterMainTabVC];
    }else{
        [self enterLoginVC];
    }
}

/**
 *  进入主界面
 */
- (void)enterMainTabVC{
    
    if (self.loginVC) {
        self.loginVC = nil;
    }
    
    self.mainTabVC = [[MainTabViewController alloc]init];

    self.window.rootViewController = self.mainTabVC;

    [self.window makeKeyAndVisible];
}

/**
 *  进入登陆界面
 */
- (void)enterLoginVC{
    
    if (self.mainTabVC) {
        self.mainTabVC = nil;
    }
    
    self.loginVC = [[LoginViewController alloc]init];
    
    UINavigationController * loginNaVc = [[UINavigationController alloc]initWithRootViewController:self.loginVC];
    self.window.rootViewController = loginNaVc;
    
    [self.window makeKeyAndVisible];
}

/**
 *  粘贴快捷
 *  直接跳到别人的视频开启界面逗宠
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    // 测试
    if ([pboard.string  isEqualToString:@"123"]) {
        NSLog(@"==========%@",pboard.string);
        WasCallViewController * BeComeVC =[[WasCallViewController alloc]initWithNibName:@"WasCallViewController" bundle:nil];
        [self.window.rootViewController presentViewController:BeComeVC animated:YES completion:nil];
        // 也有可能自己开启自己
        pboard.string  =@"";
        
        
        
        
    }else
    {
        // 正常情况
        
        
    }
}



@end
