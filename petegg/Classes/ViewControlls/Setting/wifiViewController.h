//
//  wifiViewController.h
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface wifiViewController :BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *wifiNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passCodeTF;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)MBProgressHUD *hud;


// 此wifi为家庭 非硬件热点
@end
