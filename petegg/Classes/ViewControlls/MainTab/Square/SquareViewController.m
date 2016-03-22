//
//  SquareViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "SquareViewController.h"
#import "ReView.h"
#import "SpView.h"

@interface SquareViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * rightButton;
@property(nonatomic,strong)UILabel * lineLabel;
@property(nonatomic,strong)UIButton * issueBtn;
@property(nonatomic,strong)UIBarButtonItem * petShowBUtton;

@property(nonatomic,strong)UIButton * coverBtn;
@property(nonatomic,strong)UIView * downWhiteView;
@property(nonatomic,strong)UIView * downView;
@property(nonatomic,strong)ReView * reView;
@property(nonatomic,strong)SpView * spView;

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
    [_leftButton setTitle:NSLocalizedString(@"recommend", nil) forState:UIControlStateNormal];
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
    [_rightButton setTitle:NSLocalizedString(@"sprout", nil) forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:GREEN_COLOR forState:UIControlStateSelected];
    _rightButton.selected = NO;
    [topView addSubview:_rightButton];
    [_rightButton addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setTitleView:topView];
    
    [self setTitleView:topView];
    [self showBarButton:NAV_RIGHT imageName:@"btn_new_issue"];

    _reView = [[ReView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_reView];
    
    UISwipeGestureRecognizer * leftGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonTouch)];
    leftGes.direction = UISwipeGestureRecognizerDirectionLeft;
    [_reView addGestureRecognizer:leftGes];
    

    _spView = [[SpView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_reView.frame), 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_spView];
    
    UISwipeGestureRecognizer * rightGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftbuttonTouch)];
    rightGes.direction = UISwipeGestureRecognizerDirectionRight;
    [_spView addGestureRecognizer:rightGes];

}

-(void)leftbuttonTouch{
    _leftButton.selected = YES;
    _rightButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(60, 40, 18, 1);
        _reView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _spView.frame =CGRectMake(CGRectGetMaxX(_reView.frame), 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

-(void)rightButtonTouch{
    _leftButton.selected = NO;
    _rightButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(120, 40, 18, 1);
        _reView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _spView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        
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

-(void)doRightButtonTouch{
    
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
    [downBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_downView addSubview:downBtn];
    downBtn.tag = 901;
    [downBtn addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray * nameArray = @[NSLocalizedString(@"photograph", nil),NSLocalizedString(@"photoalbum", nil),NSLocalizedString(@"repository", nil),NSLocalizedString(@"lvideo", nil)];
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
        NSLog(@"资源库");
    }else if (3 == sender.tag){
        NSLog(@"小视频");
    }
    
}









@end
