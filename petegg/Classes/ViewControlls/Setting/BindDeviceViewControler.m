//
//  BindDeviceViewControler.m
//  petegg
//
//  Created by yulei on 16/3/25.
//  Copyright © 2016年 sego. All rights reserved.
//

// 标示符


static NSString *const ServiceUUID2 =  @"1f0b6a86-0dd6-440f-8aa6-8d11f3486af0";
static NSString *const readCharacteristicUUID = @"a2e8d661-0bba-4a61-91e8-dd7ff3d55b27";
static NSString *const readwriteCharacteristicUUID = @"aa78471c-257b-49f6-93a1-8686cadb1fe6";
static NSString *const LocalNameKey =  @"segopass";

/**
 *  1f0b6a86-0dd6-440f-8aa6-8d11f3486af0
 *  a2e8d661-0bba-4a61-91e8-dd7ff3d55b27
 *  aa78471c-257b-49f6-93a1-8686cadb1fe6
 */




/**
 *  正确结果标示符
 *
 *  @return ResultDeviceID
 */

static NSString * const ResultDeviceID = @"segoegg";


#import "BindDeviceViewControler.h"
#import "wifiViewController.h"

@interface BindDeviceViewControler ()<UIAlertViewDelegate>

{
    CBPeripheralManager *peripheralManager;
    //定时器
    NSTimer *timer;
    //添加成功的service数量
    int serviceNum;
    // 服务器计数
    BOOL isAccectData;
    
    
   
}

@end

@implementation BindDeviceViewControler
@synthesize hud;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /**
     蓝牙从机  options 一定要设置为nil（余）
     */

    peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil options:nil];
  
    isAccectData = NO;
    
    
    

}
/**
 *   告知服务器蓝牙传输完成了
 *
 *  @param sender 绑定设备
 */
- (IBAction)bindBtnClick:(UIButton *)sender {
    
   

    
    

}



- (void)setupView
{
    self.view.backgroundColor =[UIColor whiteColor];
    self.bindBtnClick.backgroundColor =GREEN_COLOR;
    [self setNavTitle: NSLocalizedString(@"bindDevice", nil)];
   
    
}

//配置bluetooch的
-(void)setUp{
    //characteristics字段描述
    CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    
    NSString * str1 =@"MI16030000012833";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"bind", @"action",
                            str1,@"userid",nil];
    
    
    
    
    NSString *str = [self dictionaryToJson:params];
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    
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



#pragma  mark -- CBPeripheralManagerDelegate

//peripheralManager状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
            //在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"powered on");
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"正在拼命配置";
//            [hud hide:YES];
            

            [self setUp];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
           
            [self showWaring];
            
            break;
            
        default:
            break;
    }
}

- (void)showWaring
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你未打开蓝牙进行连接" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"去设置",nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        self.view.backgroundColor = [UIColor whiteColor];
        NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
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

//peripheral开始发送advertising
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"in peripheralManagerDidStartAdvertisiong");
    
}

//订阅characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"订阅了 %@的数据",characteristic.UUID);
    //每秒执行一次给主设备发送一个当前时间的秒数
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendData:) userInfo:characteristic  repeats:YES];
}

//取消订阅characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"取消订阅 %@的数据",characteristic.UUID);
    //取消回应
    [timer invalidate];
}

//发送数据，发送当前时间的秒数
-(BOOL)sendData:(NSTimer *)t {
    CBMutableCharacteristic *characteristic = t.userInfo;
    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    [dft setDateFormat:@"ss"];
    NSLog(@"%@",[dft stringFromDate:[NSDate date]]);
    
    //执行回应Central通知数据
    return  [peripheralManager updateValue:[[dft stringFromDate:[NSDate date]] dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:(CBMutableCharacteristic *)characteristic onSubscribedCentrals:nil];
    
}


//读characteristics请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    NSLog(@"didReceiveReadRequest");
    //判断是否有读数据的权限
    if (request.characteristic.properties & CBCharacteristicPropertyRead) {
        NSData *data = request.characteristic.value;
        [request setValue:data];
        //对请求作出成功响应
        [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }else{
        [peripheralManager respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
}


//写characteristics请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    NSLog(@"服务器写入的数据");
    CBATTRequest *request = requests[0];
        //判断是否有写数据的权限
    
   
    if (isAccectData == NO) {
        
        /**
         *  这样主要是为了 这个蓝牙的机智 毕竟人家是开启的 所以协议会走 代理也会走 方法也会走
         */
        
    
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
            hud.labelText = @"配置成功";
            [hud hide:YES afterDelay:1];
            isAccectData = YES;
            self.deviceNumLB.text = str;
            self.jieruCodeTF.text = @"123456";
            NSLog(@"是我们的数据");
            NSUserDefaults * defults =[NSUserDefaults standardUserDefaults];
            [defults setObject:str forKey:@"DEVICE_NUMBER"];
            [defults synchronize];
            /**
             不能经行服务器多次同步操作
             */
//            wifiViewController * wifVC =[[wifiViewController alloc]initWithNibName:@"wifiViewController" bundle:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }else if([AppUtil isBlankString:self.deviceNumLB.text])
        {
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.labelText=@"配置失败,请尝试重启不倒蛋";
            [hud hide:YES afterDelay:3.0];
             NSLog(@"获取设备信息失败弹出框");
            
        }

        [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }else{
        [peripheralManager respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
    }else if(isAccectData == YES)
    {
        
        
        /**
         *  不做任何事情
         *
         *  @return 
         */
    }
    
}

//
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
    NSLog(@"peripheralManagerIsReadyToUpdateSubscribers");
    
}

// 转换
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
     hud = nil;
    [hud removeFromSuperview];
    
}

@end
