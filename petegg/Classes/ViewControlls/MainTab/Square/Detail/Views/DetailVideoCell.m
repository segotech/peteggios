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
@property (nonatomic,strong)SCPlayer *player;
@end

@implementation DetailVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupView{
    
    _iconIV = [UIImageView new];
    _iconIV.contentMode = UIViewContentModeCenter;
    _iconIV.layer.masksToBounds = YES;
   // [self.contentView sd_addSubviews:@[_iconIV]];
    
    _iconIV.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).autoHeightRatio(0.75);
    
    
    
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.tag = 500;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //playerView.frame = CGRectMake(0 * W_Wide_Zoom, 0* W_Hight_Zoom, 150 * W_Wide_Zoom, 150 * W_Hight_Zoom);
   // [self.view addSubview:playerView];
    [self.contentView sd_addSubviews:@[playerView]];
   playerView.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).autoHeightRatio(0.75);
    _player.loopEnabled = YES;
    
    //[_player setItemByUrl:url];  //给赋值url
    [_player play];    //播放

    
    
    
    
}

- (void)setModel:(NSString *)model{
    
    _model = model;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    [self setupAutoHeightWithBottomView:self.iconIV bottomMargin:8];
}

@end
