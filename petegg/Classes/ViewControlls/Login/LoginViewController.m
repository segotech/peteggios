//
//  LoginViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "LoginViewController.h"

#import "AFHttpClient+Account.h"

@interface LoginViewController()
@property (nonatomic,strong)UIButton * loginButton;
@property (nonatomic,strong)UITextField * accountTextField;
@property (nonatomic,strong)UITextField * passwordTextField;

@end

@implementation LoginViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUserFace];
}
-(void)initUserFace{
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImage.image = [UIImage imageNamed:@"egg_login.jpg"];
    [self.view addSubview:backImage];
    
    UIImageView * shuruKuangImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, 375, 120)];
    shuruKuangImage.image = [UIImage imageNamed:@"egg_bigKuang.png"];
    [self.view addSubview:shuruKuangImage];

    UIImageView * topIcon = [[UIImageView alloc]initWithFrame:CGRectMake(40, 15, 20, 23)];
    topIcon.image = [UIImage imageNamed:@"egg_usertubiao.png"];
    [shuruKuangImage addSubview:topIcon];
    
    UIImageView * downIcon = [[UIImageView alloc]initWithFrame:CGRectMake(40, 75, 20, 20)];
    downIcon.image = [UIImage imageNamed:@"egg_passtubiao.png"];
    [shuruKuangImage addSubview:downIcon];
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 320, 200, 35)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.backgroundColor = GREEN_COLOR;
    _loginButton.layer.cornerRadius = 5;
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(loginTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 130, 200, 40)];
    _accountTextField.placeholder = @"请输入账号";
    _accountTextField.tintColor = [UIColor whiteColor];
    [_accountTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _accountTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:_accountTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 190, 200, 40)];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.tintColor = [UIColor whiteColor];
    [_passwordTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordTextField];
    
}


-(void)loginTouch{
    NSLog(@"登录");
//    NSString * service = [AppUtil getServerSego3];
//    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
//    NSString *strModel = [[UIDevice currentDevice] model];
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//    [dic setValue:_accountTextField.text forKey:@"accountnumber"];
//    [dic setValue:_passwordTextField.text forKey:@"password"];
//    [dic setValue:strModel forKey:@"model"];
//    [dic setValue:@"iphone" forKey:@"brand"];
//    [dic setValue:strSysVersion forKey:@"version"];
//    [dic setValue:@"" forKey:@"imei"];
//    [dic setValue:@"" forKey:@"imsi"];
//    [dic setValue:@"ios" forKey:@"type"];
//    service = [service stringByAppendingString:@"clientAction.do?common=memberLogin&classes=appinterface&method=json"];
//    AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
//    [manager POST:service parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
//          [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
//        //登出
//        // [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//
//    }];
    
    [self showHudInView:self.view hint:@"正在登录..."];
    
    [[AFHttpClient sharedAFHttpClient] loginWithUserName:self.accountTextField.text password:self.passwordTextField.text complete:^(BaseModel *model) {
        
        [self hideHud];
        
        if ([model.retCode integerValue] > 0) {
            
        }else{
            [[AccountManager sharedAccountManager] login:model.list[0]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
        }
        
    } failure:^{
        [self hideHud];
    }];
    
    
}



@end