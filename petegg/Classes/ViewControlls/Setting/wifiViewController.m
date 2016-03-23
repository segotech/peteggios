//
//  wifiViewController.m
//  petegg
//
//  Created by yulei on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "wifiViewController.h"

@interface wifiViewController ()

@end


@implementation wifiViewController
@synthesize hud;
@synthesize passCodeTF;
@synthesize wifiNameTF;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
    
    
}
// 数据
- (void)setupData
{
    
    
    
}
// 页面
- (void)setupView
{
    self.view.backgroundColor =[UIColor whiteColor];
    self.sureBtn.backgroundColor =GREEN_COLOR;
    [self setNavTitle: NSLocalizedString(@"wifiTitle", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 显示密码与否
- (IBAction)showPassWordBtn:(UIButton *)sender {
    
   
    sender.selected = !sender.selected;
    if (sender.selected) {
     
        passCodeTF.secureTextEntry = YES;
    }else{
        
        passCodeTF.secureTextEntry = NO;
        
    }
    
    
}
// 确定
- (IBAction)sureBtnClick:(id)sender {
    //这里应该等待网络请求成功返回
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在拼命加载";
    [hud hide:YES afterDelay:3.0];
    
    
   // [self.navigationController popViewControllerAnimated:YES];
}

// 导航栏
-(void) setNavTitle:(NSString*) navTitle{
    
    UILabel *lbl_navtitle=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 44)];
    lbl_navtitle.textAlignment=NSTextAlignmentCenter;
    [lbl_navtitle setTextColor:WHITE_FG];
    lbl_navtitle.text=navTitle;
    self.navigationItem.titleView=lbl_navtitle;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    hud =nil;
    passCodeTF =nil;
    
    
}

@end
