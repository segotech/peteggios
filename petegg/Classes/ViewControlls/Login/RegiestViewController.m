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
    self.title = @"注册";
    self.view.backgroundColor= [UIColor whiteColor];
    [self initUserface];
}

-(void)initUserface{
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
        //_textFieldes.backgroundColor = [UIColor blackColor];
        _textFieldes.placeholder = placeArray[i];
        [_textFieldes setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_textFieldes setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _textFieldes.tag = i + 33;
        [self.view addSubview:_textFieldes];
        
    }

    _securityButton = [[UIButton alloc]initWithFrame:CGRectMake(270 * W_Wide_Zoom, 118 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _securityButton.backgroundColor = GREEN_COLOR;
    [_securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _securityButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _securityButton.layer.cornerRadius = 5;
    [self.view addSubview:_securityButton];

}

@end
