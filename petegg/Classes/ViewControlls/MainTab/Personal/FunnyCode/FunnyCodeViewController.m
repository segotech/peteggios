//
//  FunnyCodeViewController.m
//  petegg
//
//  Created by yulei on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FunnyCodeViewController.h"

@interface FunnyCodeViewController ()

@end

@implementation FunnyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceTF.delegate = self;
    self.foodNunTF.delegate = self;
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"funTitle", nil)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
}

- (void)setupView{
    
    [self showBarButton:NAV_RIGHT imageName:@"点赞5.png"];
    
}

- (void)setupData
{
    
    
}


/**
 *   分享
 */
- (void)doRightButtonTouch

{
    
    
}
/**
 *
 * 生成逗码
 */
- (IBAction)productMycode:(UIButton *)sender {
    
   
    [[UIApplication sharedApplication].keyWindow addSubview:self.messageView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    self.messageView.hidden = NO;
    self.backView.hidden  = NO;
    self.backView.userInteractionEnabled = YES;

}
/**
 *确认
 */
- (IBAction)sureBtn:(UIButton *)sender {
    
    self.messageView.hidden = YES;
    self.backView.hidden = YES;
    
    NSString * str =@"clientAction.do?method=json&common=generatePlayCode&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"MI16010000005868" forKey:@"mid"];
//    [dic setObject:self.priceTF.text forKey:@"price"];
//    [dic setObject:self.foodNunTF.text forKey:@"tsnum"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        json = [[json objectForKey:@"jsondata"]objectForKey:@"list"];
        
        NSMutableArray * arr =[[NSMutableArray alloc]init];
        [arr addObjectsFromArray:json];
        
        
    } failure:^(NSError *error) {
        
    }];

    
    
    
    
}

/**
 *  取消
 */
- (IBAction)cancelBtn:(UIButton *)sender {
    
    self.messageView.hidden = YES;
    self.backView.hidden = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    
}

@end
