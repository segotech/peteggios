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
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"funTitle", nil)];
    
    
    
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
    
    self.messageView.hidden = NO;
    self.backView.hidden  = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.messageView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
