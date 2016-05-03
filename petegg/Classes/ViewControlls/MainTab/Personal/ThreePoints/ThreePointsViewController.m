//
//  ThreePointsViewController.m
//  petegg
//
//  Created by czx on 16/5/3.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ThreePointsViewController.h"


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
    UIImageView * tubiaobiao = [[UIImageView alloc]initWithFrame:CGRectMake(130.5 * W_Wide_Zoom, 100 * W_Hight_Zoom, 125 * W_Wide_Zoom, 125 * W_Hight_Zoom)];
    tubiaobiao.image = [UIImage imageNamed:@"tubiaobiao.png"];
    [self.view addSubview:tubiaobiao];

    UILabel * banbenLabel = [[UILabel alloc]initWithFrame:CGRectMake(150 *W_Wide_Zoom, 240 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    
    banbenLabel.text = @"SEGOV1.2";
    banbenLabel.textColor = [UIColor grayColor];
    banbenLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:banbenLabel];
    

}
-(void)loginOutButtonTouch{
    //退出登录
      [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
      [[AccountManager sharedAccountManager]logout];
}




-(void)setupData{
    [super setupData];

}





@end
