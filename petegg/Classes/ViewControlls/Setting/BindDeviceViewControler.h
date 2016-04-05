//
//  BindDeviceViewControler.h
//  petegg
//
//  Created by yulei on 16/3/25.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BindDeviceViewControler :BaseViewController<CBPeripheralManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *bindBtnClick;
@property (strong, nonatomic) IBOutlet UITextField *deviceNumLB;
@property (nonatomic,strong)MBProgressHUD *hud;
@property (strong, nonatomic) IBOutlet UITextField *jieruCodeTF;

@end
