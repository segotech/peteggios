//
//  wifiViewController.m
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

static NSString *const ServiceUUID2 =  @"1f0b6a86-0dd6-440f-8aa6-8d11f3486af0";
static NSString *const readCharacteristicUUID = @"a2e8d661-0bba-4a61-91e8-dd7ff3d55b27";
static NSString *const readwriteCharacteristicUUID = @"aa78471c-257b-49f6-93a1-8686cadb1fe6";
static NSString * const LocalNameKey =  @"segopass";
static NSString * const ResultDeviceID = @"segoegg";

#import "wifiViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Reachability.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface wifiViewController ()<CBPeripheralManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    CBPeripheralManager *peripheralManager;
    int serviceNum;
    BOOL isAccectData;
    NSArray * statsNumArr;
    // 加密选项
    NSString * mindStr;
    
    
    
}


@end


@implementation wifiViewController
@synthesize hud;
@synthesize passCodeTF;
@synthesize wifiNameTF;
@synthesize nsData;
@synthesize encryptionlistTab;



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
        //测试
        passCodeTF.text =@"Segotech@301";
    }
    
    
}
// 页面
- (void)setupView
{
    [super setupView];
    statsNumArr =@[@"无密码",@"WPA/WPA2",@"WEP"];
    encryptionlistTab.hidden = YES;
    mindStr =[NSString stringWithFormat:@"1"];
    if ([encryptionlistTab respondsToSelector:@selector(setSeparatorInset:)]) {
        [encryptionlistTab setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([encryptionlistTab respondsToSelector:@selector(setLayoutMargins:)]) {
        [encryptionlistTab setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    encryptionlistTab.tableFooterView = [[UIView alloc]init];
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
    _statsStep =@"1";
    
    peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil options:nil];
    isAccectData =  NO;

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




#pragma Mark --- boolthDelegate






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


// 转换
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/**
 *  配置蓝牙
 */

- (void)setupBlooth

{
     CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"DEVICE_NUMBER"];
    NSDictionary *params = [NSDictionary
        dictionaryWithObjectsAndKeys:@"setwifi", @"action", wifiNameTF.text,
                                     @"wifi", passCodeTF.text, @"pass", name,
                                     @"userid", mindStr,@"sec",nil];
    
    NSString *str = [self dictionaryToJson:params];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    //设置description
    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc]initWithType: CBUUIDCharacteristicUserDescriptionStringUUID value:@"name"];
    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];
    
    
    /*
     只读的Characteristic
     properties：CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable
     */
    CBMutableCharacteristic *readCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readCharacteristicUUID] properties:CBCharacteristicPropertyRead value:data permissions:CBAttributePermissionsReadable];
    
    
    //service2初始化并加入一个characteristics
    CBMutableService *service2 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID2] primary:YES];
    [service2 setCharacteristics:@[readCharacteristic,readwriteCharacteristic]];
    [peripheralManager addService:service2];

    
    
}


//perihpheral添加了service
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
        serviceNum++;
    }
    
    //因为我们添加了2个服务，所以想两次都添加完成后才去发送广播
    if (serviceNum==1) {
        //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
        //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
        [peripheralManager startAdvertising:@{
                                              CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:ServiceUUID2]],
                                              CBAdvertisementDataLocalNameKey : LocalNameKey
                                              }
         ];
        
    }
    
}



//写characteristics请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    NSLog(@"服务器写入的数据");
    CBATTRequest *request = requests[0];
    
    //判断是否有写数据的权限
        /**
         *  这样主要是为了 这个蓝牙的机智 毕竟人家是开启的 所以协议会走 代理也会走 方法也会走
         */
        
    if (!isAccectData) {
        
    
        if (request.characteristic.properties & CBCharacteristicPropertyWrite) {
            //需要转换成CBMutableCharacteristic对象才能进行写值
            CBMutableCharacteristic *c =(CBMutableCharacteristic *)request.characteristic;
            
            c.value = request.value;
            Byte * b =(Byte *)[c.value bytes];
            NSString * str =[[NSString alloc]initWithBytes:b length:c.value.length encoding:NSUTF8StringEncoding];
            NSLog(@"转换结果为===========%@",str);
            NSArray *array = [str componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
            str =array[1];
            /**
             *  Segopet730
             */
            
            if ([[str substringToIndex:7] isEqualToString:ResultDeviceID]) {
                
                /**
                 *  为了pop的页面 改变页面
                 *
                 */
                NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
                [defaults setValue:@"1" forKey:@"bindSuccesful"];
                [defaults synchronize];
                
                isAccectData =  YES;
                if ([self.fixWIFI isEqualToString:@"FIX"]) {
                    hud.labelText = @"修改成功";
                }else{
                hud.labelText = @"绑定成功";
                }
                [hud hide:YES afterDelay:1];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeCustomView;
                hud.labelText=@"绑定失败,查看蓝牙是否开启";
                [hud hide:YES afterDelay:3.0];
                NSLog(@"获取设备信息失败弹出框");
                
            }
            
            
            [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
        }else{
            [peripheralManager respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
        }
        
    }else if (isAccectData)
    {
        
        
        
    }
    
}

//peripheralManager状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
            //在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"powered on");
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"正在拼命配置";
            //            [hud hide:YES];
            
            
            [self setupBlooth];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
          
            
            break;
            
        default:
            break;
    }
}

// 点击下拉框
- (IBAction)selectEncryptionClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        encryptionlistTab.hidden = NO;
        encryptionlistTab.delegate = self;
        encryptionlistTab.dataSource = self;
        [encryptionlistTab reloadData];
    
    }else if (!sender.selected)
    
    {
        encryptionlistTab.hidden = YES;
    }
}


#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return statsNumArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell123";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showUserInfoCellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text=statsNumArr[indexPath.row];
    
    return cell;
    
}
//didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"___________%ld",(long)indexPath.row);
    if (indexPath.row ==0) {
        //Open
        [self.seletEncryption setTitle:@"无密码" forState:UIControlStateNormal];
        mindStr = [NSString stringWithFormat:@"0"];
        
    }
    if (indexPath.row ==1) {
        
        /**
         *  默认为wap
         */
        [self.seletEncryption setTitle:@"WPA/WPA2" forState:UIControlStateNormal];
        mindStr= [NSString stringWithFormat:@"1"];
        
    }else if(indexPath.row ==2)
    {
        //WEP
        
        [self.seletEncryption setTitle:@"WEP" forState:UIControlStateNormal];
        mindStr =[NSString stringWithFormat:@"2"];
    }
    self.encryptionlistTab.hidden = YES;

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
