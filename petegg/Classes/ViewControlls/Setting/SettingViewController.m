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
{
    
    NSString * str;
}

@end

@implementation SettingViewController
@synthesize solveBidBtn;
@synthesize incodeTF;
@synthesize deviceNumTF;
@synthesize setHttpBtn;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults * defults =[NSUserDefaults standardUserDefaults];
     str =[defults objectForKey:@"DEVICE_NUMBER"];
    if ([AppUtil isBlankString:str]) {
        
    
    }else
    {
        /**
         *  b-a 改变
         *
         *  @return
         */
        
        [self changeUIandData];
    }
   


    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    
}
-  (void)setupView
{
    
    self.view.backgroundColor =[UIColor whiteColor];
    setHttpBtn.backgroundColor =GREEN_COLOR;
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
    
    if ([AppUtil isBlankString:str]) {
        BindDeviceViewControler * bindDeVC = [[BindDeviceViewControler alloc]initWithNibName:@"BindDeviceViewControler" bundle:nil];
        [self.navigationController pushViewController:bindDeVC animated:YES];
        
    }else{
        
        wifiViewController * wifiVC =[[wifiViewController alloc]initWithNibName:@"wifiViewController" bundle:nil];
     
          [self.navigationController pushViewController:wifiVC animated:YES];
        
    }
  
    
}

/**
 *  绑定成功  操作界面
 */

- (void)changeUIandData
{
    
    solveBidBtn.enabled= YES;
    solveBidBtn.backgroundColor =GREEN_COLOR;
    [setHttpBtn setTitle:@"设置网络" forState:UIControlStateNormal];
    
    
}

@end
