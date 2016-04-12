//
//  FriendViewController.m
//  petegg
//
//  Created by yulei on 16/4/10.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

@synthesize headImageView;
@synthesize mytableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"tabFriend", nil)];

    
    
}


- (void)setupData
{
    
    
    
}

- (void)setupView
{
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [headImageView.layer setMasksToBounds:YES];
    [headImageView.layer setCornerRadius:30.0]; //设置矩形四个圆角半径
    headImageView.userInteractionEnabled  = YES;
    [self.view addSubview:headImageView];
    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handButton:)];
    headImageView.userInteractionEnabled = YES;
    [headImageView addGestureRecognizer:tapIcon];
    
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-44)];
    mytableView.hidden = YES;
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mytableView];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  头像点击
 */
- (void)handButton:(UITapGestureRecognizer *)sender
{

    
}


#pragma mark   ---------tableView协议----------------



@end
