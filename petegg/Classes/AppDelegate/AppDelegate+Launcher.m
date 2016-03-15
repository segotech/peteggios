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
    
    [self enterMainTabVC];
    
}

/**
 *  进入主界面
 */
- (void)enterMainTabVC{
    
    if (!self.mainTabVC) {
        
        self.mainTabVC = [[MainTabViewController alloc]init];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       GREEN_COLOR,NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
    self.window.rootViewController = self.mainTabVC;

    [self.window makeKeyAndVisible];
}

@end
