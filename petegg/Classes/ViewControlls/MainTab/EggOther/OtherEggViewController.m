//
//  OtherEggViewController.m
//  petegg
//
//  Created by yulei on 16/4/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "OtherEggViewController.h"
#import "InCallViewController.h"

@interface OtherEggViewController ()

{
    
    UIButton * button0;
    
}

@end

@implementation OtherEggViewController
@synthesize otherArr;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // sip登陆。
    
    [SephoneManager addProxyConfig:[AccountManager sharedAccountManager].loginModel.sipno password:[AccountManager sharedAccountManager].loginModel.sippw domain:@"180.97.80.152"];
    
    [self initUserface];
    [self initUserData];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdate:) name:kSephoneCallUpdate object:nil];

    [self queryDevice];
    
}


// 通话状态处理
- (void)callUpdate:(NSNotification *)notif {
    SephoneCall *call = [[notif.userInfo objectForKey:@"call"] pointerValue];
    SephoneCallState state = [[notif.userInfo objectForKey:@"state"] intValue];
    
    switch (state) {
        case SephoneCallOutgoingInit:{
            // 成功
            InCallViewController * incall =[[InCallViewController alloc]initWithNibName:@"InCallViewController" bundle:nil];
            [incall setCall:call];
            [self presentViewController:incall animated:YES completion:nil];
            
            
            break;
        }
      
        default:
            break;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSephoneCallUpdate object:nil];
}
- (void)initUserface
{
   
    self.view.backgroundColor =[UIColor whiteColor];

    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 35)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 375, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    UILabel * titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(175, 20, 100, 35)];
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


- (void)queryDevice
{
    
    NSString * mid =self.otherArr[0][@"mid"];
    NSString * devico =self.otherArr[0][@"deviceno"];
    NSString * str  = @"clientAction.do?common=queryDeviceStatus&classes=appinterface&method=json";
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"a" forKey:@"quantity"];
    [dic setValue:devico forKey:@"deviceno"];
    [dic setValue:mid forKey:@"mid"];
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        
        if ([json[@"jsondata"][@"retCode"] isEqualToString:@"0000"]) {
            
            NSString * str = json[@"jsondata"][@"retVal"][@"status"];
            [self UIinitUseface:str];
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)UIinitUseface:(NSString *)status
{

    UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(35*W_Wide_Zoom, 80*W_Hight_Zoom, 300*W_Wide_Zoom, 300*W_Hight_Zoom)];
    
    // isOpenVideoStart
    if ([status isEqualToString:@"ds001"]) {
        // 在线
        image.image =[UIImage imageNamed:@"egg_online.png"];
        [self btn_select];
        
      
    }
    else if ([status isEqualToString:@"ds003"]) {
        //通话
       image.image =[UIImage imageNamed:@"egg_calling.png"];
        [self btn_select];

        
    }
    else if ([status isEqualToString:@"ds004"]) {
        //正在上传
        image.image =[UIImage imageNamed:@"egg_upload.png"];
        [self btn_select];

        
    }else if([status isEqualToString:@"ds000"])
    {
        // 设备不存在
        
    }
    else {
        // 离线
        image.image =[UIImage imageNamed:@"egg_offline.png"];
    

    }

    
    
    [self.view addSubview:image];
    
}


- (void)btn_select

{
    button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0.layer setMasksToBounds:YES];
    [button0.layer setCornerRadius:4];
    button0.layer.borderWidth=1;
    button0.layer.borderColor = AllBackColor.CGColor;
    [button0 setBackgroundImage:[UIImage imageNamed:@"opvideo.png"] forState:UIControlStateNormal];
    button0.tag = 410925;
    button0.frame = CGRectMake(80*W_Wide_Zoom, 500*W_Hight_Zoom, 220*W_Wide_Zoom, 35*W_Hight_Zoom);
        button0.alpha =1;
        [button0 addTarget:self action:@selector(btn_set:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:button0];
}

- (void)btn_set:(UIButton * )sender
{
    
    
    // 这里判断是否具有开启视频的条件
    if ([self.otherArr[0][@"over"]intValue] <[self.otherArr[0][@"price"]intValue]) {
        // 余额不足
        
        [self showSuccessHudWithHint:@"余额不足"];
        
    }else
    {
        //  付钱提示
        
        NSString * money =[NSString stringWithFormat:@"确定支付%@￥",self.otherArr[0][@"price"]];
        UIAlertView * slertShow =[[UIAlertView alloc]initWithTitle:nil message:money delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [slertShow show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        // 取消开启视频
    }
    if (buttonIndex ==1) {
        //时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        NSString * mid =[AccountManager sharedAccountManager].loginModel.mid;
        // 使用记录
       NSString * service =@"clientAction.do?common=addDeviceUseRecord&classes=appinterface&method=json";
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        [dic setValue:@"other" forKey:@"object"];
        [dic setValue:self.otherArr[0][@"deviceno"] forKey:@"deviceno"];
        [dic setValue:self.otherArr[0][@"mid"] forKey:@"belong"];
        [dic setValue:mid forKey:@"mid"];
        [dic setValue:locationString forKey:@"starttime"];
        [dic setValue:self.otherArr[0][@"price"] forKey:@"consumption"];
        
        [AFNetWorking postWithApi:service parameters:dic success:^(id json) {
            NSString * deveOther=self.otherArr[0][@"deviceno"];
            [self sipCall:deveOther sipName:nil];
            
        } failure:^(NSError *error) {
            
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sipCall:(NSString*)dialerNumber sipName:(NSString *)sipName
{
    
    NSString *  displayName  =nil;
    [[SephoneManager instance] call:dialerNumber displayName:displayName transfer:FALSE];
    
}


@end