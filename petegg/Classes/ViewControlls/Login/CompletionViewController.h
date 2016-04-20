//
//  CompletionViewController.h
//  petegg
//
//  Created by yulei on 16/4/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"

@interface CompletionViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *timeSelect;
@property (strong, nonatomic) IBOutlet UIImageView *handImage;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIButton *birthdayBtn;

@property (strong, nonatomic) IBOutlet UITextField *nameTextF;
@end
