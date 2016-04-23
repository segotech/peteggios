//
//  WechatIssueViewController.m
//  petegg
//
//  Created by czx on 16/4/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "WechatIssueViewController.h"
#import "SCRecorder.h"
#import "SCRecordSessionManager.h"
#import "AFHttpClient+Issue.h"

@interface WechatIssueViewController ()
@property (nonatomic,strong)SCPlayer *player;
@property (nonatomic,strong)UITextField * topTextView;
@end

@implementation WechatIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
}
-(void)setupView{
    [super setupView];
    [self setNavTitle:@"发布"];
    [self showBarButton:NAV_RIGHT title:@"发布" fontColor:[UIColor blackColor]];
//    _topTextView = [[UITextView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 10 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
//    _topTextView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_topTextView];
    _topTextView = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    
     _topTextView.backgroundColor= [UIColor whiteColor];
    _topTextView.tintColor = [UIColor whiteColor];
    _topTextView.placeholder = @"请输入内容";
    [self.view addSubview:_topTextView];
    
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.tag = 500;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerView.frame = CGRectMake(0 * W_Wide_Zoom, 210* W_Hight_Zoom, 150 * W_Wide_Zoom, 150 * W_Hight_Zoom);
    [self.view addSubview:playerView];
    _player.loopEnabled = YES;
    [_player setItemByUrl:self.urlstr];
    [_player play];
    
}

-(void)doRightButtonTouch{
    
    NSMutableString * resouceStr = [[NSMutableString alloc]init];
    
    [resouceStr appendString:@".mov,"];
    [resouceStr appendString:self.str];
    [self showHudInView:self.view hint:@"正在发布..."];
    [[AFHttpClient sharedAFHttpClient]addSproutpetWithMid:[AccountManager sharedAccountManager].loginModel.mid content:_topTextView.text type:@"pv" resources:resouceStr complete:^(BaseModel *model) {
        [self hideHud];
        if ([model.retCode isEqualToString:@"0000"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
         [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
    }];


}



-(void)setupData{
    [super setupData];
    //播放小视频的窗口
   
    
}

-(void)doLeftButtonTouch{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有发布内容，是否要退出？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        [self.navigationController popToRootViewControllerAnimated:NO];
        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}



@end