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
@property (nonatomic,strong)UIButton * leftkuangbtn;
@property (nonatomic,strong)UIButton * rightkuangBtn;
@property (nonatomic,strong)UIButton * brithdayBtn;
@property (nonatomic,strong)UITextField * addressTextField;
@property (nonatomic,strong)UITextField * signTextField;
//生日的东西
@property (nonatomic,strong)UIDatePicker * datePicker;
@property (nonatomic,strong)UIView * bigView;
@property (nonatomic,strong)UIButton * bigButton;
@property (nonatomic,strong)UIButton * wanchengBtn;


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
    
    _qqTextField = [[UITextField alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 285 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    //_qqTextField.backgroundColor = [UIColor blueColor];
    _qqTextField.tintColor = GREEN_COLOR;
    _qqTextField.font = [UIFont systemFontOfSize:13];
    _qqTextField.placeholder = @"请输入qq";
    [self.view addSubview:_qqTextField];
    
    
    _leftkuangbtn = [[UIButton alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 337 * W_Hight_Zoom, 18 * W_Wide_Zoom, 17 * W_Hight_Zoom)];
    [_leftkuangbtn setImage:[UIImage imageNamed:@"kuang_off.png"] forState:UIControlStateNormal];
    [_leftkuangbtn setImage:[UIImage imageNamed:@"kuang_on.png"] forState:UIControlStateSelected];
    [_leftkuangbtn addTarget:self action:@selector(leftKuangTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftkuangbtn];
    
    _rightkuangBtn = [[UIButton alloc]initWithFrame:CGRectMake(200 * W_Wide_Zoom, 337 * W_Hight_Zoom, 18 * W_Wide_Zoom, 17 * W_Hight_Zoom)];
    [_rightkuangBtn setImage:[UIImage imageNamed:@"kuang_off.png"] forState:UIControlStateNormal];
    [_rightkuangBtn setImage:[UIImage imageNamed:@"kuang_on.png"] forState:UIControlStateSelected];
    [_rightkuangBtn addTarget:self action:@selector(rightKuangTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightkuangBtn];

    _brithdayBtn = [[UIButton alloc]initWithFrame:CGRectMake(70 * W_Wide_Zoom, 375 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_brithdayBtn setTitle:@"2016-05-13" forState:UIControlStateNormal];
    _brithdayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_brithdayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_brithdayBtn];
    [_brithdayBtn addTarget:self action:@selector(brithdayButtontouch) forControlEvents:UIControlEventTouchUpInside];
    
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 420 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _addressTextField.tintColor = GREEN_COLOR;
    _addressTextField.font = [UIFont systemFontOfSize:13];
    _addressTextField.placeholder = @"请输入地址";
    [self.view addSubview:_addressTextField];
    
    
    _signTextField = [[UITextField alloc]initWithFrame:CGRectMake(130 * W_Wide_Zoom, 465 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _signTextField.tintColor = GREEN_COLOR;
    _signTextField.font = [UIFont systemFontOfSize:13];
    _signTextField.placeholder = @"请输入签名";
    [self.view addSubview:_signTextField];
    
    

}
//生日按钮点击
-(void)brithdayButtontouch{
    _bigButton = [[UIButton alloc]initWithFrame:self.view.bounds];
    _bigButton.backgroundColor = [UIColor blackColor];
    _bigButton.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigButton];
    [_bigButton addTarget:self action:@selector(bigButtonHidden) forControlEvents:UIControlEventTouchUpInside];
    
    _datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0 * W_Wide_Zoom,200,self.view.frame.size.width,260 * W_Hight_Zoom)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:_datePicker];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    _datePicker.locale = locale;
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
   
    _wanchengBtn = [[UIButton alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 427 * W_Hight_Zoom, 375 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _wanchengBtn.backgroundColor = [UIColor whiteColor];
    [_wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_wanchengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:_wanchengBtn];
    [_wanchengBtn addTarget:self action:@selector(wanchengButtonTouch:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
}
-(void)wanchengButtonTouch:(UIButton *)sender{
   
    NSDate *pickerDate = [_datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    [_brithdayBtn setTitle:dateString forState:UIControlStateNormal];
    sender.hidden = YES;
    _bigButton.hidden = YES;
    _datePicker.hidden = YES;
}



-(void)bigButtonHidden{
    _wanchengBtn.hidden = YES;
    _bigButton.hidden = YES;
    _datePicker.hidden = YES;

}


-(void)dateChanged:(id)sender{
    NSDate *pickerDate = [sender date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    [_brithdayBtn setTitle:dateString forState:UIControlStateNormal];
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
    
    
}

//按钮点击变化
-(void)leftKuangTouch{
    _leftkuangbtn.selected = YES;
    _rightkuangBtn.selected = NO;

}

-(void)rightKuangTouch{
    _leftkuangbtn.selected = NO;
    _rightkuangBtn.selected = YES;
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
