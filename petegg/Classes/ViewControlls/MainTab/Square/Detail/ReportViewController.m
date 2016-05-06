//
//  ReportViewController.m
//  petegg
//
//  Created by czx on 16/5/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()
@property (nonatomic,strong)UIButton *button1;
@property (nonatomic,strong)NSMutableArray * datas;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"举报"];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
   
}
-(void)setupView{
    [super setupView];
    self.datas =[[NSMutableArray alloc]initWithObjects:@"色情低俗",@"广告骚扰",@"诱导分享",@"谣言",@"政治敏感",@"违法(暴力恐怖，违禁品等)",@"其他(收集隐私信息等)",nil];
    for (int i = 0 ; i < 7 ; i++) {
        UIButton * touchBtn = [[UIButton alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 80 * W_Hight_Zoom + i * 30 * W_Hight_Zoom, 15 * W_Wide_Zoom, 15 * W_Hight_Zoom)];
        [touchBtn setImage:[UIImage imageNamed:@"quan_guize.png"] forState:UIControlStateNormal];
        [touchBtn setImage:[UIImage imageNamed:@"xuanquan_guize.png"] forState:UIControlStateSelected];
        touchBtn.tag = 900001 + i;
        [touchBtn addTarget:self action:@selector(gogogogogo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:touchBtn];
        
        UILabel * labels = [[UILabel alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 73 * W_Hight_Zoom + i * 30 * W_Hight_Zoom, 280 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        labels.text = self.datas[i];
       // labels.backgroundColor = [UIColor blackColor];
        labels.font = [UIFont systemFontOfSize:13];
        labels.textColor = [UIColor blackColor];
        [self.view addSubview:labels];
    }

}

-(void)gogogogogo:(UIButton *)sender{
    for (int i=0; i<self.datas.count; i++) {
        
        _button1 = (UIButton *)[self.view viewWithTag:i+900001];
        if (_button1.tag == sender.tag) {
            
            _button1.selected = YES;
        }else {
            _button1.selected = NO;
        }
        
    }


}




@end
