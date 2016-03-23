//
//  wifiViewController.m
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "wifiViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Reachability.h"
@interface wifiViewController ()

@end


@implementation wifiViewController
@synthesize hud;
@synthesize passCodeTF;
@synthesize wifiNameTF;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isConnectionAvailable];
    
}
// 数据
- (void)setupData
{
    [super setupData];
    
     NSString *wifiTag = [self fetchSSIDInfo];
    if ([AppUtil isBlankString:wifiTag]) {
        NSLog(@"没有获取到wifi名字");
    }else
    {
        
        wifiNameTF.text = wifiTag;
        
    }
    
    
}
// 页面
- (void)setupView
{
    [super setupView];
    self.view.backgroundColor =[UIColor whiteColor];
    self.sureBtn.backgroundColor =GREEN_COLOR;
    [self setNavTitle: NSLocalizedString(@"wifiTitle", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 显示密码与否
- (IBAction)showPassWordBtn:(UIButton *)sender {
    
   
    sender.selected = !sender.selected;
    if (sender.selected) {
     
        passCodeTF.secureTextEntry = YES;
    }else{
        
        passCodeTF.secureTextEntry = NO;
        
    }
    
    
}
// 确定
- (IBAction)sureBtnClick:(id)sender {
    //这里应该等待网络请求成功返回
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在拼命加载";
    [hud hide:YES afterDelay:3.0];
    
    
   // [self.navigationController popViewControllerAnimated:YES];
}

// 获取当前所连接的WIFI
- (NSString *)fetchSSIDInfo
{
    NSString *currentSSID = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil){
        NSDictionary* myDict = (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict!=nil){
            currentSSID=[myDict valueForKey:@"SSID"];
        } else {
            currentSSID=@"<<NONE>>";
        }
    } else {
        currentSSID=@"<<NONE>>";
    }
    
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    NSDictionary *info;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
        if (info && [info count]) {
            break;
        }
    }
    
    return [info objectForKey:@"SSID"];
}

// 检查网络状态
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            [self showWarningView:NSLocalizedString(@"INFO_NetNoReachable", nil)];

            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            [self showWarningView:NSLocalizedString(@"INFO_ReachableViaWWAN", nil)];
            //NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}


- (void)showWarningView:(NSString *)str
{
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    hud.minSize = CGSizeMake(132.f, 108.0f);
    [hud hide:YES afterDelay:3];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    hud =nil;
    passCodeTF =nil;
    
    
}


@end
