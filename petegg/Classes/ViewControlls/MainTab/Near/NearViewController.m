//
//  NearViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "NearViewController.h"

@interface NearViewController ()
@property (nonatomic,strong)UIButton * seacherBtn;



@end

@implementation NearViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"tabNear", nil);
}

-(void)setupView{
    _seacherBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom,NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT , 355 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_seacherBtn setImage:[UIImage imageNamed:@"seacherkuang.png"] forState:UIControlStateNormal];
    //_seacherBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_seacherBtn];
    
    NSArray * imagearray = @[@"nearPeople.png",@"DouYiDou.png"];
    for (int i = 0 ; i < 2 ; i++) {
        UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 120 + 80 * i * W_Hight_Zoom, 40 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        headImage.image = [UIImage imageNamed:imagearray[i]];
        headImage.layer.cornerRadius = 5;
        [self.view addSubview:headImage];
    }
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 375, 1)];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabel];
    
    
    
    
}


@end