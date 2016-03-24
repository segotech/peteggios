//
//  PersonalViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController()


@end

@implementation PersonalViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"tabPersonal", nil)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
// 补改xlb
- (void)viewDidLayoutSubviews
{
    
}

- (void)setupView
{
    [super setupView];
    [self handleEndRefresh];
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    [self showBarButton:NAV_RIGHT imageName:@"new_3point.png"];
     NSArray * arrName =@[@"动态",@"录像",@"抓拍",@"关注",@"黑名单",@"逗币",@"逗码",@"权限设置",@"修改密码"];
    [self.dataSource addObjectsFromArray:arrName];
    NSArray * arrImage =@[@"person_videotape.png",@"person_photograph.png",@"person_balance.png",@"person_attention.png",@"blank_list.png",@"person_balance.png",@"person_code.png",@"person_rule.png",@"person_balance.png"];
    [self.dataSourceImage addObjectsFromArray:arrImage];
    
    
    
}
// 关于sego
- (void)doRightButtonTouch
{
    
    NSLog(@"1233");
    
    
}



@end
