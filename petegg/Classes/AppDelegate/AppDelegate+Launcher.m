//
//  AppDelegate+Launcher.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate+Launcher.h"


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
    
    self.window.rootViewController = self.loginVC;
    
    [self.window makeKeyAndVisible];
}

@end
