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
@synthesize nsData;



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
    _statsStep =@"1";
    
    [self startPostData];
    
    
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

//上传本地wifi的账户和密码，用于给segoegg联网
- (void)startPostData
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *DEVICE_NUMBER = [userDefault objectForKey:@"DEVICE_NUMBER"];
    //拼写请求参数
    NSString *service = [AppUtil getServer];
    
    NSString *op = [NSString stringWithFormat:@"{\"cmdtype\":\"TOY_CONTROL\",\"toy_control\":{\"cmdtype\":\"SET_CONFIG_PARAMETER\",\"deviceno\":\"%@\",\"config_param\":{\"type\":%d,\"param\":[{\"name\":\"WIFI_SSID\",\"value\":\"%@\"},{\"name\":\"WIFI_SECURITY\",\"value\":\"%d\"},{\"name\":\"WIFI_PASSWORD\",\"value\":\"%@\"}]}}}",DEVICE_NUMBER,201,wifiNameTF.text,1,passCodeTF.text];
    
    
    NSString *postData = [NSString stringWithFormat:@"%@%@%@%@",@"&op=",op,@"&v=",@"1.0"];
    NSURL *url = [NSURL URLWithString: service];
    
    NSLog(@"%@",postData);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSData* xmlData = [postData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:xmlData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self];
    if (connection) {
        
        
        nsData = [NSMutableData new];
        
    }
    
    
}

#pragma Mark --------connectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"连接服务器失败: %@",error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    
    [self.nsData appendData:data];
}


//成功请求并且拿到数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    // NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([_statsStep isEqualToString:@"1"]) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.nsData options:NSJSONReadingMutableContainers error:nil];
        NSString *status = [dic objectForKey:@"status"];
        if ([status isEqualToString:@"SUCCESS"]) {
            [self switchWifi];
            
            NSLog(@"将wifi用户名发送给赛果成功");
            [[NSUserDefaults standardUserDefaults]setObject:@"wifi1" forKey:@"wifiSuccess"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _statsStep = @"2";
            
        }
        
    }else if ([_statsStep isEqualToString:@"2"]){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.nsData options:NSJSONReadingMutableContainers error:nil];
        NSString *status = [dic objectForKey:@"status"];
        if ([status isEqualToString:@"SUCCESS"]) {
            [hud hide:YES];
            NSLog(@"给赛果联网成功");
            // 返回setting 让用户完成配置
    
        }
        
        
        
    }
}


- (void)switchWifi
{
    //&o p={"cmdtype":"TOY_CONTROL","toy_control":{"cmdtype":"SET_CONFIG_PARAMETER","deviceno":"73000010001","config_param":{"type":201,"param":[{"name":"WIFI_SSID","value":"hytech"},{"name":"WIFI_SECURITY","value":"1"},{"name":"WIFI_PASSWORD","value":"byqaz001"}]}}}&v=1.0
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *DEVICE_NUMBER = [userDefault objectForKey:@"DEVICE_NUMBER"];
    
    NSLog(@"DEVICE_NUMBER : %@",DEVICE_NUMBER);
    //拼写请求参数
    NSString *service = [AppUtil getServer];
    
    NSString *op = [NSString stringWithFormat:@"{\"cmdtype\":\"TOY_CONTROL\",\"toy_control\":{\"cmdtype\":\"TOGGLE_WIFI\",\"deviceno\":\"%@\",\"toggle\":{\"state\":%d}}}",DEVICE_NUMBER,0];
    
    NSString *postData = [NSString stringWithFormat:@"%@%@%@%@",@"&op=",op,@"&v=",@"1.0"];
    NSURL *url = [NSURL URLWithString: service];
    
    NSLog(@"%@",postData);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSData* xmlData = [postData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:xmlData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self];
    if (connection) {
        
        
        self.nsData = [NSMutableData new];
        
    }
    
    
    
    
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
