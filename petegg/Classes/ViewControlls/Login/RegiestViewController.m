//
//  RegiestViewController.m
//  petegg
//
//  Created by czx on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RegiestViewController.h"
#import "CompletionViewController.h"
@interface RegiestViewController ()
@property (nonatomic,strong)UITextField * textFieldes;

@property (nonatomic,strong)UIButton * securityButton;

@end

@implementation RegiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
     [self setNavTitle: NSLocalizedString(@"regist", nil)];
    
}


- (void)setupView{
    
    [super setupView];
    
    NSArray * namearray = @[@"账号:",@"验证码:",@"密码:",@"确认密码:",];
    NSArray * placeArray = @[@"请输入账号",@"请输入验证码",@"请输入密码",@"请确认密码"];
    for (int i = 0 ; i < 4; i++ ) {
        UILabel * writingLabeles = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 70 + 50 * W_Hight_Zoom * i, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
        writingLabeles.text = namearray[i];
        writingLabeles.textAlignment = NSTextAlignmentLeft;
        writingLabeles.font = [UIFont systemFontOfSize:15];
        writingLabeles.textColor = [UIColor blackColor];
        [self.view addSubview:writingLabeles];
        
        UILabel * lineLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 110 + 50 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabeles.backgroundColor = GRAY_COLOR;
        [self.view addSubview:lineLabeles];
        
        _textFieldes = [[UITextField alloc]initWithFrame:CGRectMake(120 * W_Wide_Zoom,  68 + i * 50 * W_Hight_Zoom, 200 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        _textFieldes.placeholder = placeArray[i];
        [_textFieldes setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_textFieldes setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _textFieldes.tag = i + 33;
        
        
        [self.view addSubview:_textFieldes];
        
    }
    
    
    for (NSInteger i = 0 ; i<2; i++) {
      
            UIButton * showBtn =[[UIButton alloc]initWithFrame:CGRectMake(320, 171 +i*50, 25, 25)];
            [showBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
            showBtn.tag = 1000 +i;
        [showBtn addTarget:self action:@selector(showPs:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:showBtn];
    

    }
    
    
    _securityButton = [[UIButton alloc]initWithFrame:CGRectMake(250 * W_Wide_Zoom, 118 * W_Hight_Zoom, 110 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _securityButton.backgroundColor = GREEN_COLOR;
    [_securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _securityButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _securityButton.layer.cornerRadius = 5;
    [_securityButton addTarget:self action:@selector(passwordCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_securityButton];
    
    
    
    //注册
    
    UIButton * registBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    registBtn.backgroundColor =GREEN_COLOR;
    registBtn.layer.cornerRadius =  6;
    registBtn.center = self.view.center;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    [registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    
    
    
}


- (void)setupData
{
    [super setupData];
    
    
}



/**
 *   验证码
 */


- (void)passwordCode:(UIButton *)sender
{
    
    [self proveCode];
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_securityButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                _securityButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"————————%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_securityButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _securityButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
    
}



/**
 *  注册
 */


- (void)registBtn:(UIButton *)sender
{
    
    
    CompletionViewController * compleVC =[[CompletionViewController alloc]initWithNibName:@"CompletionViewController" bundle:nil];
    [self.navigationController pushViewController:compleVC animated:YES];
    
    
    
    /*
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=check";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"13540691705" forKey:@"phone"];
    [dic setValue:@"268476" forKey:@"memberRegister"];
    [dic setValue:@"123456" forKey:@"password"];
    
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        json = [[json objectForKey:@"jsondata"]objectForKey:@"list"];

        NSLog(@"====%@",json);
        
        [self showSuccessHudWithHint:@"注册成功"];
        
    } failure:^(NSError *error) {
    }];

    */
    
    
}

/**
 *  密码显示
 */

- (void)showPs:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.tag == 1000 && sender.selected) {
        
        UITextField * textFL =(UITextField *)[self.view viewWithTag:35];
        textFL.secureTextEntry = YES;
    }else if (sender.tag ==1001 &&sender.selected){
        UITextField * textFL =(UITextField *)[self.view viewWithTag:36];
        textFL.secureTextEntry = YES;
        
    }
    else if(!sender.selected){
        UITextField * textFL =(UITextField *)[self.view viewWithTag:36];
        textFL.secureTextEntry = NO;
        UITextField * textFld =(UITextField *)[self.view viewWithTag:35];
        textFld.secureTextEntry = NO;

    }
    
    
}


/**
 *  验证码
 */

- (void)proveCode
{
    
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=check";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"13540691705" forKey:@"phone"];
    [dic setValue:@"modifypassword" forKey:@"type"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        json = [[json objectForKey:@"jsondata"]objectForKey:@"list"];
        NSMutableArray * arr =[[NSMutableArray alloc]init];
        [arr addObjectsFromArray:json];
        NSLog(@"====%@",json);
        
        
    } failure:^(NSError *error) {
    }];
    
}


@end

