//
//  SettingViewController.m
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "SettingViewController.h"
#import "wifiViewController.h"
#import "BindDeviceViewControler.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    
}
-  (void)setupView
{
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.setHttpBtn.backgroundColor =GREEN_COLOR;
    [self setNavTitle: NSLocalizedString(@"setTitle", nil)];
    

    
}
//解除绑定
- (IBAction)solvebidBtn:(id)sender {
    
    
}
/**
 *  绑定设备
 *
 *  @param sender nil
 */
- (IBAction)sethttpBtn:(id)sender {
    
    
    BindDeviceViewControler * bindDeVC = [[BindDeviceViewControler alloc]initWithNibName:@"BindDeviceViewControler" bundle:nil];
    [self.navigationController pushViewController:bindDeVC animated:YES];
    
}




@end
