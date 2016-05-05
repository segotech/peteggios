//
//  ChangePasswordViewController.m
//  petegg
//
//  Created by czx on 16/4/26.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "AFHttpClient+ChangepasswordAndBlacklist.h"
@interface ChangePasswordViewController ()
@property (nonatomic,strong)UITextField * oldPasswordTextfield;
@property (nonatomic,strong)UITextField * newpassWordTextfield;
@property (nonatomic,strong)UITextField * surePassworeTextfield;


@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"修改密码"];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)setupView{
    [super  setupView];

    NSArray * nameArray = @[@"旧密码:",@"新密码:",@"确认密码:"];
    for (int i = 0 ; i < 3; i ++) {
        UILabel * lineLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 120 + 60 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabeles.backgroundColor = GRAY_COLOR;
        [self.view addSubview:lineLabeles];
        
        UILabel * nameLabeles = [[UILabel alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 75 + i * 60 * W_Hight_Zoom, 80 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        nameLabeles.text = nameArray[i];
        nameLabeles.font = [UIFont systemFontOfSize:15];
        nameLabeles.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:nameLabeles];

    }
    _oldPasswordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 75 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _oldPasswordTextfield.font = [UIFont systemFontOfSize:14];
    _oldPasswordTextfield.placeholder = @"请输入旧密码";
    _oldPasswordTextfield.tintColor = GREEN_COLOR;
    [self.view addSubview:_oldPasswordTextfield];
    
    _newpassWordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 135 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _newpassWordTextfield.font = [UIFont systemFontOfSize:14];
    _newpassWordTextfield.placeholder = @"请输入新密码";
    _newpassWordTextfield.tintColor = GREEN_COLOR;
    [self.view addSubview:_newpassWordTextfield];
    
    _surePassworeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 195 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _surePassworeTextfield.font = [UIFont systemFontOfSize:14];
    _surePassworeTextfield.placeholder = @"请输入确定密码";
    _surePassworeTextfield.tintColor = GREEN_COLOR;
    [self.view addSubview:_surePassworeTextfield];

    
    UIButton * sureButton = [[UIButton alloc]initWithFrame:CGRectMake(87.5 * W_Wide_Zoom, 300 * W_Hight_Zoom, 200 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    sureButton.backgroundColor = GREEN_COLOR;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sureButton.layer.cornerRadius = 5;
    [self.view addSubview:sureButton];
    [sureButton addTarget:self action:@selector(sureButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setupData{
    [super  setupData];

}
-(void)sureButtonTouch{
    NSString * str = [AccountManager sharedAccountManager].loginModel.showpwd;
    if (![_oldPasswordTextfield.text isEqualToString:str]) {
        [[AppUtil appTopViewController] showHint:@"您输入的旧密码有误"];
        return;
    }
    
    if (![_newpassWordTextfield.text isEqualToString:_surePassworeTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"两次输入密码不一致"];
        return;
    }
    
    if ([AppUtil isBlankString:_newpassWordTextfield.text]) {
         [[AppUtil appTopViewController] showHint:@"请输入新密码"];
        return;
    }
    

    [[AFHttpClient sharedAFHttpClient]modifyPasswordWithMid:[AccountManager sharedAccountManager].loginModel.mid password:_newpassWordTextfield.text complete:^(BaseModel *model) {
         [[AppUtil appTopViewController] showHint:model.retDesc];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
        [[AccountManager sharedAccountManager]logout];
        // 清除plist
        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
        for(NSString* key in [dictionary allKeys]){
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }

    }];
    
    
    
    
    

}

@end
