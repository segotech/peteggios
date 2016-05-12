//
//  DetailVideoCell.m
//  petegg
//
//  Created by ldp on 16/5/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailVideoCell.h"
#import "SCRecorder.h"
#import "SCRecordSessionManager.h"

@interface DetailVideoCell()

@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) SCPlayer *player;
@property (nonatomic, strong) SCVideoPlayerView *playerView;

@end

@implementation DetailVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dada111) name:@"shuaxin11232" object:nil];

        
    }
    return self;
}
-(void)dada111{
     [_player pause];
}

- (void)setupView{
    _iconIV = [UIImageView new];
    _iconIV.contentMode = UIViewContentModeCenter;
    _iconIV.layer.masksToBounds = YES;
    // [self.contentView sd_addSubviews:@[_iconIV]];
    
    _iconIV.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).autoHeightRatio(0.75);
    
    _player = [SCPlayer player];
    _playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    _playerView.tag = 500;
    _playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.contentView sd_addSubviews:@[_playerView]];
   
    _playerView.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).autoHeightRatio(0.75);
    _player.loopEnabled = YES;
    

    
}

- (void)setModel:(NSString *)model{
    
    _model = model;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
        
    [self.player setItemByUrl:[NSURL URLWithString:model]];  //给赋值url
    [_player play];    //播放
    [self setupAutoHeightWithBottomView:self.playerView bottomMargin:8];
}








@end
