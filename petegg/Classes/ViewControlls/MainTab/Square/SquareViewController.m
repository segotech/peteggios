//
//  SquareViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "SquareViewController.h"

@interface SquareViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * rightButton;
@property(nonatomic,strong)UILabel * lineLabel;
@property(nonatomic,strong)UIButton * issueBtn;
@property(nonatomic,strong)UIBarButtonItem * petShowBUtton;

@property(nonatomic,strong)UIButton * coverBtn;
@property(nonatomic,strong)UIView * downWhiteView;
@property(nonatomic,strong)UIView * downView;

@end

@implementation SquareViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.title = NSLocalizedString(@"tabSquare", nil);
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self initUserface];
}

-(void)initUserface{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    // topView.backgroundColor =[UIColor whiteColor];
    _leftButton =[[UIButton alloc]initWithFrame:CGRectMake(50 , 10, 40 , 30 )];
    [_leftButton setTitle:@"推荐" forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftButton setTitleColor:GREEN_COLOR forState:UIControlStateSelected];
    _leftButton.selected = YES;
    
    [_leftButton addTarget:self action:@selector(leftbuttonTouch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_leftButton];
    
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 18, 1)];
    _lineLabel.backgroundColor = GREEN_COLOR;
    [topView addSubview:_lineLabel];
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(110, 10, 40, 30)];
    [_rightButton setTitle:@"萌宠" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:GREEN_COLOR forState:UIControlStateSelected];
    _rightButton.selected = NO;
    [topView addSubview:_rightButton];
    [_rightButton addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:topView];
    
    _issueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _issueBtn.frame = CGRectMake(0, 300, 18, 16);
    [_issueBtn setImage:[UIImage imageNamed:@"new_issue.png"] forState:UIControlStateNormal];
    [_issueBtn addTarget:self action:@selector(touchIssue) forControlEvents:UIControlEventTouchUpInside];
    _petShowBUtton = [[UIBarButtonItem alloc]initWithCustomView:_issueBtn];
    self.navigationItem.rightBarButtonItem = _petShowBUtton;
    
    
    
}

-(void)leftbuttonTouch{
    _leftButton.selected = YES;
    _rightButton.selected = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(60, 40, 18, 1);
        
    }];
}

-(void)rightButtonTouch{
    _leftButton.selected = NO;
    _rightButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(120, 40, 18, 1);
    }];
}
-(void)yincang:(UIButton * )sender{
    [UIView animateWithDuration:0.3 animations:^{
        _downWhiteView.frame = CGRectMake(0, 667, 375, 180);
        _downView.frame = CGRectMake(0, 667, 375, 40);
        
    }];
    if (900 == sender.tag) {
        sender.hidden = YES;
    }else{
        _coverBtn.hidden = YES;
    }
    
}


-(void)touchIssue{
    _downWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0 , 667, 375, 120 )];
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, 667, 375, 40)];
    _coverBtn = [[UIButton alloc]initWithFrame:self.view.bounds];
    _coverBtn.backgroundColor = [UIColor blackColor];
    _coverBtn.tag = 900;
    _coverBtn.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_coverBtn];
    [_coverBtn addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.3 animations:^{
        _downWhiteView.frame = CGRectMake(0, 460, 375, 160);
        _downWhiteView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downWhiteView];
        
        _downView.frame = CGRectMake(0, 627, 375, 40);
        _downView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downView];
        
    }];
    UIButton * downBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    [downBtn setTitle:@"取消" forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_downView addSubview:downBtn];
    downBtn.tag = 901;
    [downBtn addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray * nameArray = @[@"拍照",@"相册",@"资源库",@"小视频"];
    for (int i = 0 ; i < 4; i++ ) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 + 40 * i , 375, 1)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [_downWhiteView addSubview:lineLabel];
        UIButton * buttones = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 + 40 * i, 375, 40)];
        buttones.tag = i;
        [buttones setTitle:nameArray[i] forState:UIControlStateNormal];
        [buttones setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttones.titleLabel.font = [UIFont systemFontOfSize:14];
        [_downWhiteView addSubview:buttones];
        [buttones addTarget:self action:@selector(touchSonme:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)touchSonme:(UIButton *)sender{
    if (0 == sender.tag) {
        NSLog(@"拍照");
    }else if (1 == sender.tag){
        NSLog(@"录像");
    }else if (2 == sender.tag){
        NSLog(@"小视频");
    }else if (3 == sender.tag){
        NSLog(@"资源库");
    }
    
}









@end
