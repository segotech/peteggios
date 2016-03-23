//
//  EggViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "EggViewController.h"
#import "InCallViewController.h"
#import "SettingViewController.h"

@interface EggViewController ()
{
    NSArray * _equipmentStateArr;
    NSUserDefaults * _defaulte;
    UIImageView * _noDeviceImageView;
    UIImageView * _yesDeviceImageView;
    BOOL _isOpen;
    UIButton * _openButton;
    InCallViewController * _incallVC;
    
    
}
@end

@implementation EggViewController
@synthesize _appdelegate;

- (void)viewDidLoad{
    [super viewDidLoad];
    
  [self setNavTitle: NSLocalizedString(@"tabEgg", nil)];
 [self setNavTitle: NSLocalizedString(@"tabEgg", nil)];
    
    UIButton * btnFb2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btnFb2.frame=CGRectMake(0, 0, 18, 18) ;
    [btnFb2 setImage:[UIImage imageNamed:@"new_egg_seting.png"] forState:UIControlStateNormal];
    [btnFb2 addTarget:self action:@selector(settings:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:btnFb2];
    self.navigationItem.rightBarButtonItem = settings;

    
  //[self equipmentState];
    [self buttonOpen];
    
    
}

// 设置
- (void)settings:(UIButton *)sender
{
    NSLog(@"hha");
    
    SettingViewController * setVC =[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:setVC animated:YES];
    
    
}


/**
 *  通知  内存 处理
 *
 *  @param animated diss
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    
}


// 判断用户有没有绑定设备
- (void)equipmentState
{
    _equipmentStateArr =[[NSArray alloc]init];
    
    _appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _defaulte =[NSUserDefaults standardUserDefaults];
    NSString * str =[_defaulte objectForKey:@"devicenumber"];
    NSString *DEVICE_NUMBER  = [_defaulte objectForKey:@"DEVICE_NUMBER"];
    
    if ([AppUtil isBlankString:str]) {
        if ([AppUtil isBlankString:DEVICE_NUMBER]) {
            self.view.backgroundColor =[UIColor lightGrayColor];
            // 没有绑定
            _noDeviceImageView =[[UIImageView alloc]initWithFrame:CGRectMake(50, 64, 280*W_Wide_Zoom, 400*W_Hight_Zoom)];
            _noDeviceImageView.image =[UIImage imageNamed:@"noDevice.png"];
            [self.view addSubview:_noDeviceImageView];
            
        }else{
            [self queryDeviceState];
        }
        
    }
    else
    {
        self.view.backgroundColor =[UIColor whiteColor];
        //  设置界面
        [self queryDeviceState];
        
    }

    
    
}


//查询绑定设备的状态
- (void)queryDeviceState
{
    
    /**
     *  @DEVICE_NUMBER:这个是用户去绑定设备得到的设备号
     *  @devicenumber:这个是用户登录进来就有的设备号
     */
    
    NSString * bangdinDevico = [_defaulte objectForKey:@"DEVICE_NUMBER"];
    NSString * mid =[_defaulte dictionaryForKey:@"segologinIs"][@"mid"];
    NSString * devico =[_defaulte objectForKey:@"devicenumber"];
    NSString * service =[AppUtil getServerSego3];
    service = [service stringByAppendingString:@"clientAction.do?common=queryDeviceStatus&classes=appinterface&method=json"];
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"a" forKey:@"quantity"];
    
    if ([AppUtil isBlankString:devico]) {
        
        [dic setValue:bangdinDevico forKey:@"deviceno"];
        [dic setValue:mid forKey:@"mid"];
    }else
    {
        
        // 查询设备状态   // 代码可以优化（先把功能做了）
        
        [dic setValue:devico forKey:@"deviceno"];
        [dic setValue:mid forKey:@"mid"];
        
    }
    
    AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    
    [manager POST:service parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject =[responseObject objectForKey:@"jsondata"];
        if ([[responseObject objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            _equipmentStateArr =[responseObject objectForKey:@"list"];
            [self UIinitUseface:_equipmentStateArr[0][@"status"]];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];

    
    
}

- (void)UIinitUseface:(NSString *)status
{

    int myInt = [status intValue];
    self.view.backgroundColor =[UIColor whiteColor];

    _yesDeviceImageView =[[UIImageView alloc]initWithFrame:CGRectMake(35*W_Wide_Zoom, 60*W_Hight_Zoom, 300*W_Wide_Zoom, 300*W_Hight_Zoom)];
    
    if ((myInt&(0x1 << 3)) != 0) {
        // 在线
        _yesDeviceImageView.image =[UIImage imageNamed:@"egg_online.png"];
        [self buttonOpen];
    }
    else if ((myInt&(0x1 << 16)) != 0) {
        //通话
        _yesDeviceImageView.image =[UIImage imageNamed:@"egg_calling.png"];
        [self buttonOpen];
        
    }
    else if ((myInt&(0x1 << 17)) != 0) {
        //正在上传
        _yesDeviceImageView.image =[UIImage imageNamed:@"egg_upload.png"];
        [self buttonOpen];
        
    }
    else {
        // 离线
        _yesDeviceImageView.image =[UIImage imageNamed:@"egg_offline.png"];
        [_noDeviceImageView removeFromSuperview];
        
    }
    [self.view addSubview:_yesDeviceImageView];
    
}

- (void)buttonOpen
{
    _isOpen = NO;
    [_noDeviceImageView removeFromSuperview];
    _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openButton setTitle:NSLocalizedString(@"openButton", nil) forState:UIControlStateNormal];
    [_openButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _openButton.tag = 410925;
    _openButton.titleLabel.font =[UIFont systemFontOfSize:13];
    _openButton.userInteractionEnabled = YES;
    _openButton.layer.borderWidth=0.8;
    _openButton.layer.borderColor =AllBackColor.CGColor;
    [_openButton.layer setMasksToBounds:YES];
    [_openButton.layer setCornerRadius:5.0];
    [_openButton addTarget:self action:@selector(btn_set:) forControlEvents:UIControlEventTouchUpInside];
    _openButton.frame = CGRectMake(70*W_Wide_Zoom, 390*W_Hight_Zoom, 240*W_Wide_Zoom, 40*W_Hight_Zoom);
    [self.view addSubview:_openButton];
}

// 点击开启视频按钮
- (void)btn_set:(UIButton * )sender
{
    
    
    if (_isOpen) {
        
        _isOpen = NO;
        /**
         *   这里做一个模拟延迟的菊花 提高用户体验
         */
        
        NSString * devico =[_defaulte objectForKey:@"devicenumber"];
        NSString * devico1 =[_defaulte objectForKey:@"DEVICE_NUMBER"];
        
        if ([AppUtil isBlankString:devico]) {
            [self sipCall:devico1 sipName:nil];
        }else
        {
            [self sipCall:devico sipName:nil];
        }
        
        
        
        //时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
    
        NSString * mid =[_defaulte dictionaryForKey:@"segologinIs"][@"mid"];
        NSString * device =[_defaulte dictionaryForKey:@"segologinIs"][@"deviceno"];
        NSString * device1 =[_defaulte dictionaryForKey:@"segologinIs"][@"devicenumber"];
        
        
        // 使用记录
        NSString * service =[AppUtil getServerSego3];
        service = [service stringByAppendingString:@"clientAction.do?common=addDeviceUseRecord&classes=appinterface&method=json"];
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        // 自己开
        [dic setValue:@"self" forKey:@"object"];
        
        if ([AppUtil isBlankString:device]) {
            [dic setValue:device1 forKey:@"deviceno"];
            //
        }
        if ([AppUtil isBlankString:device1]) {
            
            //
            [dic setValue:device forKey:@"deviceno"];
        }
        [dic setValue:mid forKey:@"belong"];
        [dic setValue:mid forKey:@"mid"];
        [dic setValue:locationString forKey:@"starttime"];
        [dic setValue:@"0" forKey:@"consumption"];
        
        
        AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
        
        [manager POST:service parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject =[responseObject objectForKey:@"jsondata"];
            NSString * buildID =[responseObject objectForKey:@"content"];
            [_defaulte setValue:buildID forKey:@"otherbuildIDS"];
            //  开启视频
            
            _isOpen = YES;
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error.localizedDescription);
        }];
        
        
    }else
    {
        
        // 测试
        
        _incallVC =[[InCallViewController alloc]initWithNibName:@"InCallViewController" bundle:nil];
//        [self.navigationController pushViewController:_incallVC animated:YES];
        
        [self presentViewController:_incallVC animated:YES completion:nil];
        
        
        
    }
    
    
    
}

#pragma mark - Event Functions

//  call
//
/*
 @dialerNumber 别人的账号
 @sipName 自己的账号
 @ 视频通话
 */
- (void)sipCall:(NSString*)dialerNumber sipName:(NSString *)sipName
{
    
    
//    NSString *  displayName  =nil;
//    [[LinphoneManager instance] call:dialerNumber displayName:displayName transfer:FALSE];
    
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
