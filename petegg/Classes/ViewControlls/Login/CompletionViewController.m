//
//  CompletionViewController.m
//  petegg
//
//  Created by yulei on 16/4/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CompletionViewController.h"

@interface CompletionViewController ()

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor whiteColor];
     [self setNavTitle: NSLocalizedString(@"completion", nil)];
    
}


- (void)setupView{
    [super setupView];
    
}


- (void)setupData
{
    [super setupData];
    
    
}

/**
 *  XLB 点击事件
 */
- (IBAction)brithdayBtn:(UIButton *)sender {
    
    self.backView.hidden = NO;
    
}

- (IBAction)manBtn:(UIButton *)sender {
   
    [self chooseOnebtn:2004 button:sender];
    
}

- (IBAction)wowenSelect:(UIButton *)sender {
    
    [self chooseOnebtn:2003 button:sender];

}

- (IBAction)dogWindowsBtn:(UIButton *)sender {
   [self chooseOnebtn:2006 button:sender];
    
}


- (IBAction)catWindowsBtn:(UIButton *)sender {
   [self chooseOnebtn:2005 button:sender];
    
}

- (IBAction)dateTimePicker:(UIDatePicker *)sender {
    
    /*
    NSDate*selected = [self.timeSelect date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *destDateString = [dateFormatter stringFromDate:selected];
     NSString *message =  [NSString stringWithFormat: @"您选择的日期和时间是：%@",
                 destDateString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"日期和时间" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
          [alert show];
             
     */
    
    
}

- (IBAction)overViewBtn:(UIButton *)sender {
    
    self.backView.hidden = YES;
    NSDate*selected = [self.timeSelect date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    [self.birthdayBtn setTitle:destDateString forState:UIControlStateNormal];
   
}

// 点击完成
- (IBAction)overBtn:(UIButton *)sender {
    
    
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=writeData";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:self.nameTextF.text forKey:@"nickname"];
    [dic setValue:self.birthdayBtn.titleLabel.text forKey:@"pet_birthday"];
    [dic setValue:@"喵" forKey:@"pet_race"];
    [dic setValue:@"公" forKey:@"pet_sex"];
    [dic setValue:@"MI16010000005868" forKey:@"mid"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        json = [[json objectForKey:@"jsondata"]objectForKey:@"list"];
        NSMutableArray * arr =[[NSMutableArray alloc]init];
        [arr addObjectsFromArray:json];
        NSLog(@"====%@",json);
        
        
    } failure:^(NSError *error) {
    }];

    
}


- (void)chooseOnebtn:(NSInteger )tag button:(UIButton *)sender
{
    UIButton * btn =(UIButton *)[self.view viewWithTag:tag];
    if (!btn.selected) {
        sender.selected =!sender.selected;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
