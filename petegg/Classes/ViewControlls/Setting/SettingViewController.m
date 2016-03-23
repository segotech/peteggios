//
//  SettingViewController.m
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "SettingViewController.h"
#import "wifiViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.setHttpBtn.backgroundColor =GREEN_COLOR;
    
    [self setNavTitle: NSLocalizedString(@"setTitle", nil)];
    
  
}
//解除绑定
- (IBAction)solvebidBtn:(id)sender {
    
    
}
// 设置网络
- (IBAction)sethttpBtn:(id)sender {
    
    
    wifiViewController * WiFiVC = [[wifiViewController alloc]initWithNibName:@"wifiViewController" bundle:nil];
    [self.navigationController pushViewController:WiFiVC animated:YES];
    
}


// 导航栏
-(void) setNavTitle:(NSString*) navTitle{
    
    UILabel *lbl_navtitle=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 44)];
    lbl_navtitle.textAlignment=NSTextAlignmentCenter;
    [lbl_navtitle setTextColor:WHITE_FG];
    lbl_navtitle.text=navTitle;
    self.navigationItem.titleView=lbl_navtitle;
    
}

@end
