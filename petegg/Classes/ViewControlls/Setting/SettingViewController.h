//
//  SettingViewController.h
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SettingViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *solveBidBtn;
@property (strong, nonatomic) IBOutlet UIButton *setHttpBtn;
@property (strong, nonatomic) IBOutlet UITextField *deviceNumTF;
@property (strong, nonatomic) IBOutlet UITextField *incodeTF;

@end
