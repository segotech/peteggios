//
//  DetailVideoCell.m
//  petegg
//
//  Created by ldp on 16/5/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailVideoCell.h"

@interface DetailVideoCell()

@property (nonatomic, strong) UIImageView *iconIV;

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
    [self.contentView sd_addSubviews:@[_iconIV]];
    
    _iconIV.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).autoHeightRatio(0.75);
}

- (void)setModel:(NSString *)model{
    
    _model = model;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    [self setupAutoHeightWithBottomView:self.iconIV bottomMargin:8];
}

@end
