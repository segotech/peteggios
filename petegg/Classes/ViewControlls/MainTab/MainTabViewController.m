//
//  MainTabViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "MainTabViewController.h"

#import "SquareViewController.h"
#import "NearViewController.h"
#import "EggViewController.h"
#import "RankViewController.h"
#import "PersonalViewController.h"
#import "SettingViewController.h"
#import "UITabBar+Badge.h"
@interface MainTabViewController()
{
    
    dispatch_source_t timer3;
    AppDelegate * app;
    
    
    
}

//广场
@property (nonatomic, strong) UINavigationController* navSquareVC;
//附近
@property (nonatomic, strong) UINavigationController* navNearVC;
//不倒蛋
@property (strong, nonatomic) UINavigationController  *navEggVC;
//榜单
@property (strong, nonatomic) UINavigationController  *navRankVC;
//个人中心
@property (strong, nonatomic) UINavigationController  *navPersonalVC;

@end

@implementation MainTabViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    app= (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(check:) name:@"checkSatats" object:nil];
    
      [self check];

    
    
}

- (void)setupSubviews
{
    self.tabBar.backgroundColor=[UIColor whiteColor];
    
    self.viewControllers = @[
                             self.navSquareVC,
                             self.navNearVC,
                             self.navEggVC,
                             self.navRankVC,
                             self.navPersonalVC
                             ];
    
}

//广场
- (UINavigationController *)navSquareVC{
    if (!_navSquareVC) {
        
        SquareViewController* vc = [[SquareViewController alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabSquare", nil)
                                      image:[[UIImage imageNamed:@"tab_square_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_square_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navSquareVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navSquareVC;
}

//附近
- (UINavigationController *)navNearVC{
    if (!_navNearVC) {
        
        NearViewController* vc = [[NearViewController alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabNear", nil)
                                      image:[[UIImage imageNamed:@"tab_near_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_near_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navNearVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navNearVC;
}

//不倒蛋
- (UINavigationController *)navEggVC{
    if (!_navEggVC) {
        
        EggViewController* vc = [[EggViewController alloc] init];
        
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabEgg", nil)
                                      image:[[UIImage imageNamed:@"tab_egg_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_egg_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navEggVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navEggVC;
}




//榜单
- (UINavigationController *)navRankVC{
    if (!_navRankVC) {
        
        RankViewController* vc = [[RankViewController alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabRank", nil)
                                      image:[[UIImage imageNamed:@"tab_rank_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_rank_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _navRankVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navRankVC;
}

//个人中心
- (UINavigationController *)navPersonalVC{
    
    [self isMessage];
    if (!_navPersonalVC) {
        
       PersonalViewController* vc = [[PersonalViewController alloc] init];
        // 明天写
        vc.messageCount = @"4";
    
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabPersonal", nil)
                                      image:[[UIImage imageNamed:@"tab_personal_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_personal_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [self.tabBar showBadgeOnItemIndex:4];
        
       _navPersonalVC = [[UINavigationController alloc]initWithRootViewController:vc];
        
    }
    
    return _navPersonalVC;
}

- (void)check
{
    
    NSTimeInterval period = 5.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer3 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer3, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer3, ^{
        
        [self compareDoubleTime];
        
        
    });
    dispatch_resume(timer3);
    
    
}
/**
 *  对比时间差
 */

- (void)compareDoubleTime
{
    
    NSLog(@"===================================");
    
    NSString *date = [AppUtil getNowTime];
    int dateOver = [self spare:date];
    
    NSUserDefaults *standDefus = [NSUserDefaults standardUserDefaults];
    NSString *dateEnd = [standDefus objectForKey:@"endTime"];
    int dateEndOver = [self spare:dateEnd];
    // dateEndOver = (dateOver -dateEndOver)/60 + (dateOver -dateEndOver)%60;
    dateEndOver = dateOver - dateEndOver;
    
    if ([AppUtil isBlankString:[standDefus objectForKey:@"content"]]) {
        
    } else {
        // 先查询状态视频状态
        
        NSString *service =
        [NSString stringWithFormat:@"clientAction.do?common=queryTask&classes="
         @"appinterface&method=json&tid=%@",
         [standDefus objectForKey:@"content"]];
        [AFNetWorking postWithApi:service
            parameters:nil
            success:^(id json) {
              json = [json objectForKey:@"jsondata"];
              if ([[json objectForKey:@"content"] isEqualToString:@"0"]) {
                // 在对比时间 做出判断
                if (dateEndOver >= 600) {
                  // 已经超时
                  dispatch_suspend(timer3);
                    [self showMessageWarring:@"超时" view:app.window];
                    
                 [standDefus removeObjectForKey:@"content"];

                } else {
                 

                }
              }
              if ([[json objectForKey:@"content"] isEqualToString:@"1"]) {
                // 上传成功
                [self showMessageWarring:@"上传成功" view:app.window];
                [standDefus removeObjectForKey:@"content"];
                dispatch_suspend(timer3);
              }
              if ([[json objectForKey:@"content"] isEqualToString:@"2"]) {
                  dispatch_suspend(timer3);
                  [self showMessageWarring:@"上传失败" view:app.window];
                 [standDefus removeObjectForKey:@"content"];
             
            }

            }

            failure:^(NSError *error){
               [self showMessageWarring:@"网络错误" view:app.window];
                
            }];
    }
}

- (int )spare:(NSString *)str
{
    int a =[[str substringWithRange:NSMakeRange(0, 2)] intValue];
    int b =[[str substringWithRange:NSMakeRange(3, 2)] intValue];
    int c=[[str substringWithRange:NSMakeRange(6, 2)] intValue];
    a= a*3600+b*60+c;
    return a;
    
}


/**
 *  消息提示
 */

- (void)isMessage
{
    
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
    [dicc setValue:@"MI16010000005868" forKey:@"mid"];
    NSString * service =[NSString stringWithFormat:@"clientAction.do?common=trendTipCount&classes=appinterface&method=json"];
    [AFNetWorking postWithApi:service parameters:dicc success:^(id json) {
        json = [json objectForKey:@"jsondata"] ;
        
        if ([AppUtil isBlankString:json[@"content"]]) {
           
            
        }else{
            [self.tabBar showBadgeOnItemIndex:4];
            
        }
        
    } failure:^(NSError *error) {
        
       
        
    }];
    

    
}

@end
