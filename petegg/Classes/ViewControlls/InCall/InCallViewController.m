//
//  InCallViewController.m
//  petegg
//
//  Created by yulei on 16/3/21.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "InCallViewController.h"

@interface InCallViewController ()

@end

@implementation InCallViewController
@synthesize laserPen;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
   
    
    
}


- (void)setupView
{
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor =[UIColor whiteColor];
    UIImage *thumbImage =[UIImage imageNamed:@"1.png"];
    UIImage *thumbImage1 =[UIImage imageNamed:@"2.png"];
    [laserPen setThumbImage:thumbImage1 forState:UIControlStateHighlighted];
    [laserPen setThumbImage:thumbImage forState:UIControlStateNormal];
   
    
}

// 滑动红外线
- (IBAction)moveBtnClick:(UISlider *)sender {
    
}


//喂食
- (IBAction)feedBtnClick:(UIButton *)sender {
    
}


// 开灯
- (IBAction)lightBtnClick:(UIButton *)sender {
    
}

// 零食
- (IBAction)juankFootBtnClick:(UIButton *)sender {
    
}
//抓拍
- (IBAction)photoBtnClick:(UIButton *)sender {
    
}


//  返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 上
- (IBAction)beforBtnClick:(UIButton *)sender {
    

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
