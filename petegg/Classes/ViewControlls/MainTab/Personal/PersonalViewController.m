//
//  PersonalViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController()<UITableViewDataSource,UITableViewDelegate>

{
    
    UITableView * perListTB;
    
}

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
    UIButton * btnFb2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btnFb2.frame=CGRectMake(0, 0, 18, 18) ;
    [btnFb2 setImage:[UIImage imageNamed:@"new_3point.png"] forState:UIControlStateNormal];
    [btnFb2 addTarget:self action:@selector(aboutSego:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:btnFb2];
    self.navigationItem.rightBarButtonItem = settings;
    
    
    perListTB =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    
    [self.view addSubview:perListTB];
    
    
}

// 关于sego
- (void)aboutSego:(UIButton *)sender
{
    
    
    
}


- (void)setupData
{
    [super setupData];
    
}

#pragma MARK  ------  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
// header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 39*W_Hight_Zoom;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
// 
//    
//    return cell;
//    
//}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
