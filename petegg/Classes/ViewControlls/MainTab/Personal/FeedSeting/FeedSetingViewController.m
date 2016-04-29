//
//  FeedSetingViewController.m
//  petegg
//
//  Created by czx on 16/4/28.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FeedSetingViewController.h"
#import "AFHttpClient+FeedingClient.h"
#import "FeedSetingTableViewCell.h"


@interface FeedSetingViewController ()
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIButton * oneDayButton;
@property (nonatomic,strong)UIButton * twoDayButton;
@property (nonatomic,strong)UIView * moveView;

@end

@implementation FeedSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"喂食设置"];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
}

-(void)setupView{
    [super setupView];
    _bigBtn = [[UIButton alloc]initWithFrame:CGRectMake(87.5 * W_Wide_Zoom, 80 * W_Hight_Zoom , 200 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    _bigBtn.backgroundColor = [UIColor blueColor];
    _bigBtn.layer.cornerRadius = _bigBtn.width/2;
    [self.view addSubview:_bigBtn];
    
    UILabel * wenziLabel = [[UILabel alloc]initWithFrame:CGRectMake(87.5 * W_Wide_Zoom, 300 * W_Hight_Zoom, 80 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    wenziLabel.text = @"喂食天数";
    wenziLabel.textColor = [UIColor blackColor];
    wenziLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:wenziLabel];
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(230 * W_Wide_Zoom, 300 * W_Hight_Zoom, 80 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 3;
    [self.view addSubview:whiteView];
    
    _oneDayButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 40 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_oneDayButton setTitle:@"一天" forState:UIControlStateNormal];
    _oneDayButton.backgroundColor = [UIColor whiteColor];
    _oneDayButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_oneDayButton setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    [whiteView addSubview:_oneDayButton];
    [_oneDayButton addTarget:self action:@selector(onedayButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    

    
    _twoDayButton = [[UIButton alloc]initWithFrame:CGRectMake(40 * W_Wide_Zoom, 0 * W_Hight_Zoom, 40 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_twoDayButton setTitle:@"两天" forState:UIControlStateNormal];
    _twoDayButton.backgroundColor = [UIColor whiteColor];
    _twoDayButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_twoDayButton setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    [whiteView addSubview:_twoDayButton];
    [_twoDayButton addTarget:self action:@selector(twoDayButtontouch) forControlEvents:UIControlEventTouchUpInside];
    
    _moveView = [[UIView alloc]initWithFrame:CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom)];
    _moveView.backgroundColor = GREEN_COLOR;
    [whiteView addSubview:_moveView];
    
    
    self.tableView.frame = CGRectMake(0 * W_Wide_Zoom, 300 * W_Hight_Zoom, self.view.width, 400);
   //[self.tableView registerClass:[PermissTableViewCell class] forCellReuseIdentifier:cellId];
   // [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
    
}

-(void)onedayButtonTouch{
    _oneDayButton.selected = YES;
    _twoDayButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
     [[AppUtil appTopViewController] showHint:@"启用一天模式"];
    
    }];
}

-(void)twoDayButtontouch{
    _oneDayButton.selected = NO;
    _twoDayButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _moveView.frame = CGRectMake(42 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
         [[AppUtil appTopViewController] showHint:@"启用两天模式"];
        
    }];

}

-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]queryFeedingtimeWithMid:[AccountManager sharedAccountManager].loginModel.mid complete:^(BaseModel *model) {
        
    }];
}


@end