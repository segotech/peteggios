//
//  OtherEggViewController.m
//  petegg
//
//  Created by yulei on 16/4/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "OtherEggViewController.h"

@interface OtherEggViewController ()

@end

@implementation OtherEggViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUserface];
    [self initUserData];
    
}

- (void)initUserface
{
    self.view.backgroundColor =[UIColor whiteColor];
    UILabel *lbl_navtitle=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 44)];
    lbl_navtitle.textAlignment=NSTextAlignmentCenter;
    [lbl_navtitle setTextColor:[UIColor darkGrayColor]];
    lbl_navtitle.text=@"不捣蛋";
    self.navigationItem.titleView=lbl_navtitle;

    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 35)];
    // [backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 325, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    UILabel * titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 100, 35)];
    titelLabel.text = @"视频";
    titelLabel.textColor = [UIColor blackColor];
    titelLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titelLabel];

    
    
    
}


- (void)initUserData
{
    
    
    
}


/**
 *  返回
 */

- (void)back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
