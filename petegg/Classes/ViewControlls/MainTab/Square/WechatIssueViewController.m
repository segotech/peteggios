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

@interface WechatIssueViewController ()
@property (nonatomic,strong)SCPlayer *player;
@end

@implementation WechatIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"发布"];
    
}
-(void)setupView{
    [super setupView];
    

}

-(void)setupData{
    [super setupData];
    //播放小视频的窗口
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.tag = 500;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerView.frame = CGRectMake(100, 200, 150, 150);
    [self.view addSubview:playerView];
    _player.loopEnabled = YES;
    [_player setItemByUrl:self.urlstr];
    [_player play];
    
}

-(void)doLeftButtonTouch{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有发布内容，是否要退出？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        [self.navigationController popToRootViewControllerAnimated:NO];
        //              [[NSNotificationCenter defaultCenter]postNotificationName:@"godai" object:nil];
        //              [[NSNotificationCenter defaultCenter]postNotificationName:@"godai2" object:nil];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
    
    
    
    

}

@end
