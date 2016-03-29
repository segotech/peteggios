//
//  IssuePinViewController.m
//  petegg
//
//  Created by czx on 16/3/26.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "IssuePinViewController.h"

@interface IssuePinViewController ()
@property (nonatomic,strong)UITextView * topTextView;
@property (nonatomic,strong)UIView * downWithView;
@property (nonatomic,strong)UIButton * coverButton;
@property (nonatomic,strong)UIView * littleDownView;
@property (nonatomic,strong)NSMutableArray * imageArray;

@end

@implementation IssuePinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setTitle:@"发布"];
   
}
-(void)setupView{
    [super setupData];
    _topTextView = [[UITextView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 10 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    _topTextView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topTextView];
    _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObject:_firstImage];
    [self addImageS];
    
    
}

-(void)setupData{
    [super setupData];

}

-(void)addImageS{
    //    UIButton * testButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    //testButton.backgroundColor = [UIColor redColor];
    //    [testButton setImage:_firstImage forState:UIControlStateNormal];
    //    [self.view addSubview:testButton];
    //    [testButton addTarget:self action:@selector(openDownView) forControlEvents:UIControlEventTouchUpInside];
//    NSMutableArray * array = [[NSMutableArray alloc]init];
//    array = [NSMutableArray arrayWithArray:_imageArray];
    
    [_imageArray addObject:[UIImage imageNamed:@"addImage.png"]];
        for (int i = 0 ; i < _imageArray.count; i++) {
            UIButton * buttones = [[UIButton alloc]initWithFrame:CGRectMake(0 + i * 90, 220, 80, 80)];
            [buttones setImage:_imageArray[i] forState:UIControlStateNormal];
            [self.view addSubview:buttones];
            buttones.tag = i;
            [buttones addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
}

-(void)buttonTouch:(UIButton *)sender{
    if (sender.tag == _imageArray.count - 1) {
        [self openDownView];
    }else{
        NSLog(@"进入大图模式");
    }

}

-(void)openDownView{
    _downWithView = [[UIView alloc]initWithFrame:CGRectMake(0, 667, 375, 80)];
    _littleDownView = [[UIView alloc]initWithFrame:CGRectMake(0, 667, 375, 40)];
    _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    _coverButton.backgroundColor = [UIColor blackColor];
    _coverButton.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_coverButton];
    [_coverButton addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        _downWithView.frame = CGRectMake(0, 530, 375, 80);
        _littleDownView.frame = CGRectMake(0, 627, 375, 40);
        _littleDownView.backgroundColor = [UIColor whiteColor];
        _downWithView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_littleDownView];
        [[UIApplication sharedApplication].keyWindow addSubview:_downWithView];
    }];
    NSArray * nameArray = @[NSLocalizedString(@"photograph", nil),NSLocalizedString(@"photoalbum", nil),NSLocalizedString(@"repository", nil),NSLocalizedString(@"lvideo", nil)];
    for (int i = 0; i < 2; i++) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 + i * 40, 375, 1)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [_downWithView addSubview:lineLabel];

        UIButton * downButtones = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 + i * 40, 375, 40)];
        
        
        
        
    }
    

}


-(void)hideButton:(UIButton *)sender{
    sender.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _downWithView.frame = CGRectMake(0, 667, 375, 80);
        _littleDownView.frame = CGRectMake(0, 667, 375, 40);
    }];
    

}



@end