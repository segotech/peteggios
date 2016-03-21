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

@interface MainTabViewController()

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
    
    [self setupSubviews];
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
        UIButton * btnFb2 =[UIButton buttonWithType:UIButtonTypeCustom];
        btnFb2.frame=CGRectMake(0, 0, 18, 18) ;
        [btnFb2 setImage:[UIImage imageNamed:@"new_egg_seting.png"] forState:UIControlStateNormal];
        [btnFb2 addTarget:self action:@selector(settings:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:btnFb2];
        vc.navigationItem.rightBarButtonItem = settings;

        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabEgg", nil)
                                      image:[[UIImage imageNamed:@"tab_egg_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_egg_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navEggVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navEggVC;
}


// 设置
- (void)settings:(UIButton *)sender
{
    NSLog(@"hha");
    
    
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
    if (!_navPersonalVC) {
        
        PersonalViewController* vc = [[PersonalViewController alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabPersonal", nil)
                                      image:[[UIImage imageNamed:@"tab_personal_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"tab_personal_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _navPersonalVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navPersonalVC;
}
@end
