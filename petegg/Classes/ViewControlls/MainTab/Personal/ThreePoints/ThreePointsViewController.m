//
//  ThreePointsViewController.m
//  petegg
//
//  Created by czx on 16/5/3.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ThreePointsViewController.h"
#import "LoginViewController.h"

@interface ThreePointsViewController ()

@end

@implementation ThreePointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setNavTitle:@"关于"];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    
}

-(void)setupView{
    [super setupView];
    UIButton * tuichu = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    tuichu.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tuichu];
    [tuichu addTarget:self action:@selector(loginOutButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)loginOutButtonTouch{
    [[AccountManager sharedAccountManager]logout];
    LoginViewController * loginVc = [[LoginViewController alloc]init];
    [self presentViewController:loginVc animated:NO completion:nil];
    
}




-(void)setupData{
    [super setupData];

}





@end
