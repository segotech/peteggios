//
//  PersonInformationViewController.m
//  petegg
//
//  Created by czx on 16/4/25.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonInformationViewController.h"

@interface PersonInformationViewController ()
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UIButton * manBtn;
@property (nonatomic,strong)UIButton * womanBtn;
@property (nonatomic,strong)UITextField * nameTextField;
@property (nonatomic,strong)UITextField * qqTextField;
@property (nonatomic,strong)UIButton * onkuangbtn;
@property (nonatomic,strong)UIButton * offkuangBtn;
@property (nonatomic,strong)UITextField * addressTextField;
@property (nonatomic,strong)UITextField * signTextField;



@end

@implementation PersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"修改个人信息"];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)setupView{
    [super setupView];
    NSArray * nameArray = @[@"性别",@"昵称",@"QQ",@"家族",@"生日",@"地址",@"签名"];
    for (int i  = 0 ; i < 7 ; i ++) {
        UILabel * lineLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 230 + 45 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabeles.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineLabeles];
        
        UILabel * nameLabeles = [[UILabel alloc]initWithFrame:CGRectMake(55 * W_Wide_Zoom, 195 + 45 * i * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        nameLabeles.font = [UIFont systemFontOfSize:15];
        nameLabeles.text = nameArray[i];
        nameLabeles.textColor = [UIColor blackColor];
        [self.view addSubview:nameLabeles];
    }
    _manBtn = [[UIButton alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 202 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [_manBtn setImage:[UIImage imageNamed:@"manAnimal.png"] forState:UIControlStateNormal];
    [_manBtn setImage:[UIImage imageNamed:@"manSelect.png"] forState:UIControlStateSelected];
    _manBtn.selected = YES;
    [self.view addSubview:_manBtn];
    [_manBtn addTarget:self action:@selector(sexTouch1) forControlEvents:UIControlEventTouchUpInside];
    
    
    _womanBtn = [[UIButton alloc]initWithFrame:CGRectMake(200 * W_Wide_Zoom, 202 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [_womanBtn setImage:[UIImage imageNamed:@"womenAnimal.png"] forState:UIControlStateNormal];
    [_womanBtn setImage:[UIImage imageNamed:@"wanmenSelect.png"] forState:UIControlStateSelected];
    [self.view addSubview:_womanBtn];
    [_womanBtn addTarget:self action:@selector(sexTouch2) forControlEvents:UIControlEventTouchUpInside];
    
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 240 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _nameTextField.tintColor = GREEN_COLOR;
    _nameTextField.font = [UIFont systemFontOfSize:13];
   // _nameTextField.backgroundColor = [UIColor blueColor];
    _nameTextField.placeholder = @"请输入昵称";
    [self.view addSubview:_nameTextField];
    
   // _qqTextField = [UITextField alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
}

-(void)sexTouch1{
    _manBtn.selected = YES;
    _womanBtn.selected = NO;


}
-(void)sexTouch2{
    _womanBtn.selected = YES;
    _manBtn.selected = NO;
}


-(void)setupData{
    [super setupData];

}


@end
