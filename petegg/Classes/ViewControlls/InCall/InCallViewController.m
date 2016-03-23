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
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIImage *thumbImage =[UIImage imageNamed:@"1.png"];
    UIImage *thumbImage1 =[UIImage imageNamed:@"2.png"];
    [laserPen setThumbImage:thumbImage1 forState:UIControlStateHighlighted];
    [laserPen setThumbImage:thumbImage forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
