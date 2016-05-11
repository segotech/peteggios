//
//  AppDelegate+Launcher.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate+Launcher.h"
#import "OtherEggViewController.h"

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
    // 判断登录
    
    
    // 判断是否是自己
    
    
    
    if ([pboard.string length]>4  &&  [[pboard.string substringWithRange:NSMakeRange(0, 4)]  isEqualToString:@"赛果分享"]) {
        NSString * strPLAYcode = [pboard.string substringWithRange:NSMakeRange(5,14 )];
        [self checkPlayCode:strPLAYcode];
        pboard.string  =@"";
    }else
    {
        // 正常情况
        
        
    }
}



- (void)checkPlayCode:(NSString *)playStr
{
    
    NSString * str =@"clientAction.do?method=json&common=queryPlayCodeRule&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [dic setValue:playStr forKey:@"playcode"];
    
    NSLog(@"==========%@",playStr);
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        NSMutableArray * arr =[NSMutableArray array];
            arr = json[@"jsondata"][@"list"];
        if ([arr[0][@"status"] isEqualToString:@"0"]) {
            
            [self.window.rootViewController showSuccessHudWithHint:@"此逗码已经失效"];
        }else
        {
            
            OtherEggViewController * otherVC =[[OtherEggViewController alloc]init];
            otherVC.otherArr = arr;
            [self.window.rootViewController presentViewController:otherVC animated:YES completion:nil];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
   
    
}

@end
