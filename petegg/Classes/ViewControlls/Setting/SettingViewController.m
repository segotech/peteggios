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
    // 绑定成功标示符
    NSString * strBind;
    
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
     strBind =[defults objectForKey:@"bindSuccesful"];
    if ([AppUtil isBlankString:str]) {
        
        
    }else if ([strBind isEqualToString:@"1"] && str!=nil)
    {
       
        [self changeUIandData:@"修改网络"];
        deviceNumTF.text = [NSString stringWithFormat:@" 设备号:%@",str];
        incodeTF.text = [NSString stringWithFormat:@" 接入码:FFO23"];
        
    }
    else
    {
        /**
         *  b-a 改变
         *
         *  @return
         */
        deviceNumTF.text = [NSString stringWithFormat:@" 设备号:%@",str];
        incodeTF.text = [NSString stringWithFormat:@" 接入码:FFO23"];
        [self changeUIandData:@"设置网络"];
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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *mid = [userDefault objectForKey:@"segomid"];
    NSString *service = [AppUtil getServerSego3];
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
    [dicc setValue:mid                forKey:@"mid"];
    service = [service stringByAppendingString:@"clientAction.do?common=delDevice&classes=appinterface&method=json"];
    
    AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    
    [manager POST:service parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic1 = [responseObject objectForKey:@"jsondata"] ;
        
        if ([[dic1 objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DEVICE_NUMBER"];
            
        }
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"解除绑定失败");
              
              
    }];
    
    
}

/**
 *  绑定设备
 */
- (IBAction)sethttpBtn:(id)sender {
    
    // 绑定设备
    if ([AppUtil isBlankString:str]) {
        BindDeviceViewControler * bindDeVC = [[BindDeviceViewControler alloc]initWithNibName:@"BindDeviceViewControler" bundle:nil];
        [self.navigationController pushViewController:bindDeVC animated:YES];
        
    }
    // 修改网络
    else if(strBind!=nil && str!= nil)
    {
        
        wifiViewController * wifiVC =[[wifiViewController alloc]initWithNibName:@"wifiViewController" bundle:nil];
        wifiVC.fixWIFI =@"FIX";
        [self.navigationController pushViewController:wifiVC animated:YES];

        
    }
    else{
        // 网络设置
        wifiViewController * wifiVC =[[wifiViewController alloc]initWithNibName:@"wifiViewController" bundle:nil];
          [self.navigationController pushViewController:wifiVC animated:YES];
        
    }
  
    
}

/**
 *  绑定成功  操作界面
 */

- (void)changeUIandData:(NSString *)title
{
    
    solveBidBtn.enabled= YES;
    solveBidBtn.backgroundColor =GREEN_COLOR;
    [setHttpBtn setTitle:title forState:UIControlStateNormal];
    
    
}

@end
