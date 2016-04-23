//
//  FunnyCodeViewController.h
//  petegg
//
//  Created by yulei on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FunnyCodeViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *onFunyCode;
@property (strong, nonatomic) IBOutlet UILabel *onFunprice;
@property (strong, nonatomic) IBOutlet UILabel *onFunfood;
@property (strong, nonatomic) IBOutlet UILabel *onFuntime;
@property (strong, nonatomic) IBOutlet UIButton *onFunCodeBtn;


@end
