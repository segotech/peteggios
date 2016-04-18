//
//  RegiestViewController.m
//  petegg
//
//  Created by czx on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RegiestViewController.h"

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
        
        if (i>=3) {
            UIButton * showBtn =[[UIButton alloc]initWithFrame:CGRectMake(320, 218+(i-3+50), 40, 40)];
            [showBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
            [self.view  addSubview:showBtn];
            
        }
        
        [self.view addSubview:_textFieldes];
        
    }
    
    _securityButton = [[UIButton alloc]initWithFrame:CGRectMake(270 * W_Wide_Zoom, 118 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
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
    
    
    
    
}



/**
 *  注册
 */


- (void)registBtn:(UIButton *)sender
{
    
    
    
}
@end
